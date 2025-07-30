import 'package:equatable/equatable.dart';

import '../../../domain/entities/item.dart';

/// Enum representing different states of search
enum SearchStatus {
  initial,
  loading,
  success,
  empty,
  failure;

  bool get isInitial => this == SearchStatus.initial;
  bool get isLoading => this == SearchStatus.loading;
  bool get isSuccess => this == SearchStatus.success;
  bool get isEmpty => this == SearchStatus.empty;
  bool get isFailure => this == SearchStatus.failure;
}

/// State for SearchBloc
class SearchState extends Equatable {
  const SearchState({
    this.status = SearchStatus.initial,
    this.query = '',
    this.filteredItems = const [],
    this.message,
  });

  final SearchStatus status;
  final String query;
  final List<Item> filteredItems;
  final String? message;

  factory SearchState.initial() => const SearchState();

  SearchState copyWith({
    SearchStatus? status,
    String? query,
    List<Item>? filteredItems,
    String? message,
  }) {
    return SearchState(
      status: status ?? this.status,
      query: query ?? this.query,
      filteredItems: filteredItems ?? this.filteredItems,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, query, filteredItems, message];
}
