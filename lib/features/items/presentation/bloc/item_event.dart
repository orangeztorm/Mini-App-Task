import 'package:equatable/equatable.dart';

/// Base class for all item events
abstract class ItemEvent extends Equatable {
  const ItemEvent();

  @override
  List<Object> get props => [];
}

/// Event to load items
class LoadItemsEvent extends ItemEvent {
  const LoadItemsEvent();
}

/// Event to refresh items
class RefreshItemsEvent extends ItemEvent {
  const RefreshItemsEvent();
}

/// Event to load more items (for pagination)
class LoadMoreItemsEvent extends ItemEvent {
  const LoadMoreItemsEvent();
}

/// Event to toggle favorite status of an item
class ToggleFavoriteEvent extends ItemEvent {
  const ToggleFavoriteEvent({required this.itemId});

  final int itemId;

  @override
  List<Object> get props => [itemId];
}

/// Event to search items by title
class SearchItemsEvent extends ItemEvent {
  const SearchItemsEvent({required this.query});

  final String query;

  @override
  List<Object> get props => [query];
}

/// Event to clear search
class ClearSearchEvent extends ItemEvent {
  const ClearSearchEvent();
}
