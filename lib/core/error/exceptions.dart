/// Custom exceptions for the application
class ServerException implements Exception {
  const ServerException([this.message = 'Server error occurred']);
  final String message;
}

class CacheException implements Exception {
  const CacheException([this.message = 'Cache error occurred']);
  final String message;
}

class NetworkException implements Exception {
  const NetworkException([this.message = 'Network connection failed']);
  final String message;
}
