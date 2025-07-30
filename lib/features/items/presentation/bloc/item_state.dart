import 'package:equatable/equatable.dart';

import '../../domain/entities/item.dart';

/// Enum for different loading states
enum ItemStatus { initial, loading, loadingMore, success, failure, refreshing }

/// State class for items
class ItemState extends Equatable {
  const ItemState({
    this.status = ItemStatus.initial,
    this.items = const [],
    this.filteredItems = const [],
    this.favoriteCount = 0,
    this.searchQuery = '',
    this.errorMessage = '',
    this.hasReachedMax = false,
  });

  final ItemStatus status;
  final List<Item> items;
  final List<Item> filteredItems;
  final int favoriteCount;
  final String searchQuery;
  final String errorMessage;
  final bool hasReachedMax;

  /// Get the items to display (filtered if search is active, otherwise all items)
  List<Item> get displayItems => searchQuery.isEmpty ? items : filteredItems;

  /// Check if loading
  bool get isLoading => status == ItemStatus.loading;

  /// Check if loading more
  bool get isLoadingMore => status == ItemStatus.loadingMore;

  /// Check if refreshing
  bool get isRefreshing => status == ItemStatus.refreshing;

  /// Check if has error
  bool get hasError => status == ItemStatus.failure;

  /// Check if has data
  bool get hasData => items.isNotEmpty;

  /// Check if search is active
  bool get isSearching => searchQuery.isNotEmpty;

  /// Create a copy of this state with some fields replaced
  ItemState copyWith({
    ItemStatus? status,
    List<Item>? items,
    List<Item>? filteredItems,
    int? favoriteCount,
    String? searchQuery,
    String? errorMessage,
    bool? hasReachedMax,
  }) {
    return ItemState(
      status: status ?? this.status,
      items: items ?? this.items,
      filteredItems: filteredItems ?? this.filteredItems,
      favoriteCount: favoriteCount ?? this.favoriteCount,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage ?? this.errorMessage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [
    status,
    items,
    filteredItems,
    favoriteCount,
    searchQuery,
    errorMessage,
    hasReachedMax,
  ];
}
