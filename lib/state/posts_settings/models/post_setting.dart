import 'package:instagram_clone_course/state/posts_settings/constants/constants.dart';

enum PostSetting {
  allowLikes(
    title: Constants.allowLikesTitle,
    description: Constants.allowLikesDescription,
    storagekey: Constants.allowLikesStorageKey,
  ),
  allowComments(
    title: Constants.allowCommentsTitle,
    description: Constants.allowCommentsDescription,
    storagekey: Constants.allowCommentsStorageKey,
  );

  final String title;
  final String description;
  final String storagekey;
  const PostSetting({
    required this.title,
    required this.description,
    required this.storagekey,
  });
}
