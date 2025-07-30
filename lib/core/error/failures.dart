import 'package:equatable/equatable.dart';

/// Abstract base class for all failures in the application
abstract class Failure extends Equatable {
  const Failure([this.message = 'An unexpected error occurred']);

  final String message;

  @override
  List<Object> get props => [message];
}

/// Failure for server-related errors
class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server error occurred']);
}

/// Failure for cache-related errors
class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache error occurred']);
}

/// Failure for network connectivity issues
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Network connection failed']);
}

/// Failure for general exceptions
class GeneralFailure extends Failure {
  const GeneralFailure([super.message = 'An unexpected error occurred']);
}

/// Failure for validation errors
class ValidationFailure extends Failure {
  const ValidationFailure([super.message = 'Validation failed']);
}
