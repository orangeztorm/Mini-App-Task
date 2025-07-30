import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/item.dart';

/// Abstract repository interface for item operations
abstract class ItemRepository {
  /// Get all items from remote data source
  Future<Either<Failure, List<Item>>> getItems();

  /// Get cached items from local data source
  Future<Either<Failure, List<Item>>> getCachedItems();

  /// Cache items to local data source
  Future<Either<Failure, void>> cacheItems(List<Item> items);

  /// Toggle favorite status of an item
  Future<Either<Failure, void>> toggleFavorite(int itemId);

  /// Get favorite item IDs from local storage
  Future<Either<Failure, List<int>>> getFavoriteItemIds();
}
