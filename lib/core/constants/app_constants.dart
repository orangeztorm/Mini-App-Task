/// Application-wide constants
class AppConstants {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String itemsEndpoint = '/posts';

  // Cache keys
  static const String cachedItemsKey = 'CACHED_ITEMS';
  static const String favoriteItemsKey = 'FAVORITE_ITEMS';

  // Error messages
  static const String serverFailureMessage = 'Server Failure';
  static const String cacheFailureMessage = 'Cache Failure';
  static const String networkFailureMessage = 'Network Failure';

  // Timeouts
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
}
