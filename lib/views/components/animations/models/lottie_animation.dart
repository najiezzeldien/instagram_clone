// ignore_for_file: public_member_api_docs, sort_constructors_first

enum LottieAnimation {
  dataNotFound(name: "data_not_found"),
  empty(name: "empty"),
  loading(name: "loading"),
  error(name: "error"),
  smallError(name: "small_error");

  final String name;
  const LottieAnimation({
    required this.name,
  });
}
