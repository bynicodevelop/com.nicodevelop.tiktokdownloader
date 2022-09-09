class InvalidUrlException implements Exception {
  static const String invalidUrlException = "InvalidUrlException";

  final String? message;

  InvalidUrlException(
    this.message,
  );

  @override
  String toString() {
    return message ?? invalidUrlException;
  }
}
