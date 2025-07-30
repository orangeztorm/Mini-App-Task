import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failures.dart';

/// Abstract base class for all use cases
///
/// [Type] - the return type of the use case
/// [Params] - the input parameters for the use case
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Use case that doesn't require any parameters
class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
