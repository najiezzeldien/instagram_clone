import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_course/state/posts_settings/models/post_setting.dart';
import 'package:instagram_clone_course/state/posts_settings/notifiers/post_settings_notifier.dart';

final postSettingProvider =
    StateNotifierProvider<PostSettingNotifier, Map<PostSetting, bool>>(
  (ref) => PostSettingNotifier(),
);
