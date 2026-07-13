class DeepLinkManager {
  DeepLinkManager._();

  static final instance = DeepLinkManager._();

  void Function(String)? onDeepLink;

  String? _pendingPayload;

  void handle(String payload) {
    if (onDeepLink != null) {
      onDeepLink!(payload);
      return;
    }

    _pendingPayload = payload;
  }

  String? consumePendingPayload() {
    final payload = _pendingPayload;
    _pendingPayload = null;
    return payload;
  }
}