class APINotDefinedError extends Error {
  final String message = "TETRIS_API, environment variable, is not defined";
  APINotDefinedError();

  @override
  String toString() => message;
}

class RepositoryURLRegexException implements Exception {
  final String repository_url;
  final String pattern;
  const RepositoryURLRegexException(this.repository_url, this.pattern);

  @override
  String toString() => 'RepositoryURLRegexException: ${repository_url} didn\'t match pattern ${pattern}';
}