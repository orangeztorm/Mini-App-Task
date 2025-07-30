import '../models/item_model.dart';

/// Abstract interface for remote data source
abstract class ItemRemoteDataSource {
  /// Get items from remote API
  ///
  /// Throws [ServerException] on server error
  /// Throws [NetworkException] on network error
  Future<List<ItemModel>> getItems();
}
