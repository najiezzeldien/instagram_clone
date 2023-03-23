import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_course/state/constants/firebase_collection_name.dart';
import 'package:instagram_clone_course/state/image_upload/constants/constsnts.dart';
import 'package:instagram_clone_course/state/image_upload/exceptions/could_not_build_thumbnail_exception.dart';
import 'package:instagram_clone_course/state/image_upload/extenstions/get_collection_name_from_file_type.dart';
import 'package:instagram_clone_course/state/image_upload/extenstions/get_image_data_aspect_ratio.dart';
import 'package:instagram_clone_course/state/image_upload/models/file_type.dart';
import 'package:instagram_clone_course/state/image_upload/typedefs/is_loading.dart';
import 'package:instagram_clone_course/state/posts/models/post_payload.dart';
import 'package:instagram_clone_course/state/posts/typedefs/user_id.dart';
import 'package:instagram_clone_course/state/posts_settings/models/post_setting.dart';
import 'package:uuid/uuid.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ImageUploadNotifier extends StateNotifier<IsLoading> {
  ImageUploadNotifier() : super(false);
  set isLoading(bool value) => state = value;
  Future<bool> upload({
    required File file,
    required FileType fileType,
    required String message,
    required Map<PostSetting, bool> postSettings,
    required UserId userId,
  }) async {
    isLoading = true;
    late Uint8List thumbnailUint8List;
    switch (fileType) {
      case FileType.image:
        final fileAsImage = img.decodeImage(file.readAsBytesSync());
        if (fileAsImage == null) {
          isLoading = false;
          throw const CouldNotBuildThumbnailExcption();
        }
        // Create thumbnail
        final thumbnail = img.copyResize(
          fileAsImage,
          width: Constants.imageThumbnailWidth,
        );
        final thumbnailData = img.encodeJpg(thumbnail);
        thumbnailUint8List = Uint8List.fromList(thumbnailData);
        break;
      case FileType.video:
        final thumb = await VideoThumbnail.thumbnailData(
          video: file.path,
          imageFormat: ImageFormat.JPEG,
          maxHeight: Constants.vidioThumbnailMaxHeight,
          quality: Constants.vidioThumbnailQuality,
        );
        if (thumb == null) {
          isLoading = false;
          throw const CouldNotBuildThumbnailExcption();
        } else {
          thumbnailUint8List = thumb;
        }
        break;
    }
    // Calculate the aspect ratio
    final thumbnailAspectRatio = await thumbnailUint8List.getAspectRatio();
    // Calculate references
    final fileName = const Uuid().v4();
    // Create references to the thumbnail and the image itself
    final thumbnailRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(FirebaseCollectionName.thumbnails)
        .child(fileName);
    final originalFileRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(fileType.collectionName)
        .child(fileName);
    try {
      // upload the thumbnail
      final thumbnailUploadTask =
          await thumbnailRef.putData(thumbnailUint8List);
      final thumbnailStorageId = thumbnailUploadTask.ref.name;
      // upload the original file
      final originalFileUploadTask = await originalFileRef.putFile(file);
      final originalFileStorageId = originalFileUploadTask.ref.name;
      // upload the post itself
      final postPayLoad = PostPayload(
        userId: userId,
        message: message,
        thumbnailUrl: await thumbnailRef.getDownloadURL(),
        fileUrl: await originalFileRef.getDownloadURL(),
        fileType: fileType,
        fileName: fileName,
        aspectRatio: thumbnailAspectRatio,
        thumbnailStorageId: thumbnailStorageId,
        orignalFileStorageId: originalFileStorageId,
        postSettings: postSettings,
      );
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.posts)
          .add(postPayLoad);
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
