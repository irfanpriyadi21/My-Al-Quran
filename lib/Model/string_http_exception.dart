class StringHttpException implements Exception {
  final String message;
  StringHttpException(this.message);

  @override
  String toString() {
    return message;
  }
}
