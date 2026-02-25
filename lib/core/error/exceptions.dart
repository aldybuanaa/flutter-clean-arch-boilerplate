/// Exception thrown when a server/API call fails.
class ServerException implements Exception {
  final String message;

  const ServerException({this.message = 'An unexpected server error occurred'});

  @override
  String toString() => 'ServerException: $message';
}

/// Exception thrown when a local cache operation fails.
class CacheException implements Exception {
  final String message;

  const CacheException({this.message = 'An unexpected cache error occurred'});

  @override
  String toString() => 'CacheException: $message';
}
