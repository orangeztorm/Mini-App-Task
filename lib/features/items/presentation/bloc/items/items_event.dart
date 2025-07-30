import 'package:equatable/equatable.dart';

/// Base class for all items events
abstract class ItemsEvent extends Equatable {
  const ItemsEvent();

  @override
  List<Object> get props => [];
}

/// Event to load items
class LoadItemsEvent extends ItemsEvent {
  const LoadItemsEvent();
}

/// Event to refresh items
class RefreshItemsEvent extends ItemsEvent {
  const RefreshItemsEvent();
}

/// Event to load more items (for pagination)
class LoadMoreItemsEvent extends ItemsEvent {
  const LoadMoreItemsEvent();
}
