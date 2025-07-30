import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'search_event.dart';
import 'search_state.dart';

/// BLoC responsible for managing search functionality
@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState.initial()) {
    on<SearchItemsEvent>(_onSearchItems);
    on<ClearSearchEvent>(_onClearSearch);
  }

  /// Handle searching items
  Future<void> _onSearchItems(
    SearchItemsEvent event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.isEmpty) {
      emit(
        state.copyWith(
          status: SearchStatus.initial,
          query: '',
          filteredItems: [],
        ),
      );
      return;
    }

    emit(state.copyWith(status: SearchStatus.loading, query: event.query));

    // Simulate slight delay for search (optional, for better UX)
    await Future.delayed(const Duration(milliseconds: 300));

    try {
      final filteredItems = event.allItems.where((item) {
        return item.title.toLowerCase().contains(event.query.toLowerCase());
      }).toList();

      if (filteredItems.isEmpty) {
        emit(
          state.copyWith(
            status: SearchStatus.empty,
            filteredItems: [],
            message: 'No items found for "${event.query}"',
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: SearchStatus.success,
            filteredItems: filteredItems,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: SearchStatus.failure,
          message: 'Search failed. Please try again.',
        ),
      );
    }
  }

  /// Handle clearing search
  Future<void> _onClearSearch(
    ClearSearchEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchState.initial());
  }
}
