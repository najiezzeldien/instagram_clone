import 'dart:collection' show MapView;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone_course/state/image_upload/models/file_type.dart';
import 'package:instagram_clone_course/state/posts/models/post_key.dart';
import 'package:instagram_clone_course/state/posts/typedefs/user_id.dart';
import 'package:instagram_clone_course/state/posts_settings/models/post_setting.dart';

@immutable
class PostPayload extends MapView<String, dynamic> {
  PostPayload({
    required UserId userId,
    required String message,
    required String thumbnailUrl,
    required String fileUrl,
    required FileType fileType,
    required String fileName,
    required double aspectRatio,
    required String thumbnailStorageId,
    required String orignalFileStorageId,
    required Map<PostSetting, bool> postSettings,
  }) : super(
          {
            PostKey.userId: userId,
            PostKey.message: message,
            PostKey.createdAt: FieldValue.serverTimestamp(),
            PostKey.thumbnailUrl: thumbnailUrl,
            PostKey.fileUrl: fileUrl,
            PostKey.fileType: fileType.name,
            PostKey.fileName: fileName,
            PostKey.aspectRatio: aspectRatio,
            PostKey.thumbnailStorageId: thumbnailStorageId,
            PostKey.originalFileStorageId: orignalFileStorageId,
            PostKey.postSettings: {
              for (final postSetting in postSettings.entries)
                postSetting.key.storagekey: postSetting.value
            },
          },
        );
}
