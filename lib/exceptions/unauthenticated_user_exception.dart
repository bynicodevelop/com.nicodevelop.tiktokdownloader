class UnauthenticatedUserException implements Exception {
  static const String unauthenticatedUserException =
      "UnauthenticatedUserException";

  final String? message;

  UnauthenticatedUserException(
    this.message,
  );

  @override
  String toString() {
    return message ?? unauthenticatedUserException;
  }
}
