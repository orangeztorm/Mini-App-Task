import 'package:equatable/equatable.dart';

import '../../../domain/entities/item.dart';

/// Base class for all search events
abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

/// Event to search items by query
class SearchItemsEvent extends SearchEvent {
  const SearchItemsEvent({required this.query, required this.allItems});

  final String query;
  final List<Item> allItems;

  @override
  List<Object> get props => [query, allItems];
}

/// Event to clear search
class ClearSearchEvent extends SearchEvent {
  const ClearSearchEvent();
}
