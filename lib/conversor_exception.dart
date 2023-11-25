class ConversorException implements Exception {
  final String message;

  ConversorException(this.message);

  @override
  String toString() {
    return message;
  }
}