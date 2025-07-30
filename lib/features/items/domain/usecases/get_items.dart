import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/item.dart';
import '../repositories/item_repository.dart';

/// Use case for getting items with caching strategy
@injectable
class GetItems implements UseCase<List<Item>, NoParams> {
  const GetItems(this._repository);

  final ItemRepository _repository;

  @override
  Future<Either<Failure, List<Item>>> call(NoParams params) async {
    // Try to get cached items first
    final cachedResult = await _repository.getCachedItems();

    return cachedResult.fold(
      (failure) async {
        // If cache fails, try to get from remote
        final remoteResult = await _repository.getItems();
        return remoteResult.fold((remoteFailure) => Left(remoteFailure), (
          items,
        ) async {
          // Cache the items for future use
          await _repository.cacheItems(items);
          return Right(items);
        });
      },
      (cachedItems) async {
        // If we have cached items, also try to refresh from remote in background
        if (cachedItems.isNotEmpty) {
          // Return cached items immediately
          _repository.getItems().then((remoteResult) {
            remoteResult.fold(
              (failure) => null, // Ignore remote failure if we have cached data
              (items) => _repository.cacheItems(items),
            );
          });
          return Right(cachedItems);
        } else {
          // If cache is empty, get from remote
          final remoteResult = await _repository.getItems();
          return remoteResult.fold((failure) => Left(failure), (items) async {
            await _repository.cacheItems(items);
            return Right(items);
          });
        }
      },
    );
  }
}
