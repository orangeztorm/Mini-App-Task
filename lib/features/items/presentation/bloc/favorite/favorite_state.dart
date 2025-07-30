import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';

/// Enum representing different states of favorite operations
enum FavoriteStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == FavoriteStatus.initial;
  bool get isLoading => this == FavoriteStatus.loading;
  bool get isSuccess => this == FavoriteStatus.success;
  bool get isFailure => this == FavoriteStatus.failure;
}

/// State for FavoriteBloc
class FavoriteState extends Equatable {
  const FavoriteState({
    this.status = FavoriteStatus.initial,
    this.favoriteIds = const [],
    this.failure,
    this.message,
  });

  final FavoriteStatus status;
  final List<int> favoriteIds;
  final Failure? failure;
  final String? message;

  factory FavoriteState.initial() => const FavoriteState();

  FavoriteState copyWith({
    FavoriteStatus? status,
    List<int>? favoriteIds,
    Failure? failure,
    String? message,
  }) {
    return FavoriteState(
      status: status ?? this.status,
      favoriteIds: favoriteIds ?? this.favoriteIds,
      failure: failure ?? this.failure,
      message: message ?? this.message,
    );
  }

  /// Get favorite count
  int get favoriteCount => favoriteIds.length;

  /// Check if an item is favorite
  bool isFavorite(int itemId) => favoriteIds.contains(itemId);

  @override
  List<Object?> get props => [status, favoriteIds, failure, message];
}
