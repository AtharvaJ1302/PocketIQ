class DeepLinkManager {
  DeepLinkManager._();

  static final instance = DeepLinkManager._();

  void Function(String)? onDeepLink;

  String? _currentPayload;

  void handle(String payload) {
    _currentPayload = payload;

    onDeepLink?.call(payload);
  }

  String? get payload => _currentPayload;

  String? consumePayload() {
    final value = _currentPayload;
    _currentPayload = null;
    return value;
  }

}