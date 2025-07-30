import '../models/item_model.dart';

/// Abstract interface for local data source
abstract class ItemLocalDataSource {
  /// Get cached items from local storage
  ///
  /// Throws [CacheException] if no cached data is found
  Future<List<ItemModel>> getCachedItems();

  /// Cache items to local storage
  ///
  /// Throws [CacheException] on cache write error
  Future<void> cacheItems(List<ItemModel> items);

  /// Toggle favorite status of an item
  ///
  /// Throws [CacheException] on cache write error
  Future<void> toggleFavorite(int itemId);

  /// Get favorite item IDs from local storage
  ///
  /// Returns empty list if no favorites found
  Future<List<int>> getFavoriteItemIds();
}
