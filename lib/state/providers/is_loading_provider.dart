import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_course/state/auth/providers/auth_state_provider.dart';
import 'package:instagram_clone_course/state/image_upload/providers/image_uploader_provider.dart';

final isLoadingProvider = Provider<bool>(
  (ref) {
    final authState = ref.watch(authStateProvider);
    final isUpLoadingImage = ref.watch(imageUploadProvider);

    return authState.isLoading || isUpLoadingImage;
  },
);
