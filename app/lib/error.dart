class APINotDefinedError extends Error {
  final String message = "TETRIS_API, environment variable, is not defined";
  APINotDefinedError();

  @override
  String toString() => message;
}