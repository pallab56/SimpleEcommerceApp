// ServerException, CacheException — thrown by data-layer datasources.
class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException({required this.message, this.statusCode});
}
