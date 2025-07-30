import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/item_repository.dart';

/// Use case for getting favorite item IDs
@injectable
class GetFavoriteItemIds implements UseCase<List<int>, NoParams> {
  const GetFavoriteItemIds(this._repository);

  final ItemRepository _repository;

  @override
  Future<Either<Failure, List<int>>> call(NoParams params) async {
    return await _repository.getFavoriteItemIds();
  }
}
