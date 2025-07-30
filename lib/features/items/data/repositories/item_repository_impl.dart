import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/item.dart';
import '../../domain/repositories/item_repository.dart';
import '../datasources/item_local_data_source.dart';
import '../datasources/item_remote_data_source.dart';
import '../models/item_model.dart';

/// Implementation of [ItemRepository]
@Injectable(as: ItemRepository)
class ItemRepositoryImpl implements ItemRepository {
  const ItemRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  final ItemRemoteDataSource remoteDataSource;
  final ItemLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, List<Item>>> getItems() async {
    try {
      // Try to get items from remote source first (which now includes fallback to mock data)
      final remoteItems = await remoteDataSource.getItems();
      final favoriteIds = await localDataSource.getFavoriteItemIds();

      // Update items with favorite status
      final itemsWithFavorites = remoteItems.map((item) {
        return item.copyWith(isFavorite: favoriteIds.contains(item.id));
      }).toList();

      // Cache the items
      await localDataSource.cacheItems(itemsWithFavorites);

      return Right(itemsWithFavorites.map((item) => item.toEntity()).toList());
    } catch (e) {
      // If remote fails, try to get cached items (which includes mock data fallback)
      try {
        final cachedItems = await localDataSource.getCachedItems();
        return Right(cachedItems.map((item) => item.toEntity()).toList());
      } catch (cacheError) {
        return const Left(CacheFailure('Failed to load items'));
      }
    }
  }

  @override
  Future<Either<Failure, List<Item>>> getCachedItems() async {
    try {
      final cachedItems = await localDataSource.getCachedItems();
      return Right(cachedItems.map((item) => item.toEntity()).toList());
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(GeneralFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> cacheItems(List<Item> items) async {
    try {
      final itemModels = items
          .map((item) => ItemModel.fromEntity(item))
          .toList();
      await localDataSource.cacheItems(itemModels);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(GeneralFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> toggleFavorite(int itemId) async {
    try {
      await localDataSource.toggleFavorite(itemId);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(GeneralFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, List<int>>> getFavoriteItemIds() async {
    try {
      final favoriteIds = await localDataSource.getFavoriteItemIds();
      return Right(favoriteIds);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(GeneralFailure('Unexpected error: $e'));
    }
  }
}
