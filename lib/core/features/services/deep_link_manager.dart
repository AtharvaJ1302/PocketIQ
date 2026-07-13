class DeepLinkManager {
  DeepLinkManager._();

  static final instance = DeepLinkManager._();

  void Function(String)? onDeepLink;

  void handle(String payload) {
    onDeepLink?.call(payload);
  }

}