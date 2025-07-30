import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/item_repository.dart';

/// Use case for toggling favorite status of an item
@injectable
class ToggleFavorite implements UseCase<void, ToggleFavoriteParams> {
  const ToggleFavorite(this._repository);

  final ItemRepository _repository;

  @override
  Future<Either<Failure, void>> call(ToggleFavoriteParams params) async {
    return await _repository.toggleFavorite(params.itemId);
  }
}

/// Parameters for ToggleFavorite use case
class ToggleFavoriteParams extends Equatable {
  const ToggleFavoriteParams({required this.itemId});

  final int itemId;

  @override
  List<Object> get props => [itemId];
}
