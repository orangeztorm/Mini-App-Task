import 'package:equatable/equatable.dart';

import '../../../domain/entities/item.dart';
import '../../../../../core/error/failures.dart';

/// Enum representing different states of items loading
enum ItemsStatus {
  initial,
  loading,
  loadingMore,
  success,
  failure;

  bool get isInitial => this == ItemsStatus.initial;
  bool get isLoading => this == ItemsStatus.loading;
  bool get isLoadingMore => this == ItemsStatus.loadingMore;
  bool get isSuccess => this == ItemsStatus.success;
  bool get isFailure => this == ItemsStatus.failure;
}

/// State for ItemsBloc
class ItemsState extends Equatable {
  const ItemsState({
    this.status = ItemsStatus.initial,
    this.items = const [],
    this.failure,
    this.message,
    this.hasReachedMax = false,
  });

  final ItemsStatus status;
  final List<Item> items;
  final Failure? failure;
  final String? message;
  final bool hasReachedMax;

  factory ItemsState.initial() => const ItemsState();

  ItemsState copyWith({
    ItemsStatus? status,
    List<Item>? items,
    Failure? failure,
    String? message,
    bool? hasReachedMax,
  }) {
    return ItemsState(
      status: status ?? this.status,
      items: items ?? this.items,
      failure: failure ?? this.failure,
      message: message ?? this.message,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [status, items, failure, message, hasReachedMax];
}
