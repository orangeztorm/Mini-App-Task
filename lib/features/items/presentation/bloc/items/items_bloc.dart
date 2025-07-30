import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecases/get_items.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/error/failures.dart';
import 'items_event.dart';
import 'items_state.dart';

/// BLoC responsible for managing items loading state
@injectable
class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  ItemsBloc(this._getItems) : super(ItemsState.initial()) {
    on<LoadItemsEvent>(_onLoadItems);
    on<RefreshItemsEvent>(_onRefreshItems);
    on<LoadMoreItemsEvent>(_onLoadMoreItems);
  }

  final GetItems _getItems;
  static const int _itemsPerPage = 20; // For pagination

  /// Handle loading items
  Future<void> _onLoadItems(
    LoadItemsEvent event,
    Emitter<ItemsState> emit,
  ) async {
    emit(state.copyWith(status: ItemsStatus.loading));

    final result = await _getItems(NoParams());

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ItemsStatus.failure,
          failure: failure,
          message: _mapFailureToMessage(failure),
        ),
      ),
      (items) => emit(
        state.copyWith(
          status: ItemsStatus.success,
          items: items,
          hasReachedMax: items.length < _itemsPerPage,
        ),
      ),
    );
  }

  /// Handle refreshing items
  Future<void> _onRefreshItems(
    RefreshItemsEvent event,
    Emitter<ItemsState> emit,
  ) async {
    emit(state.copyWith(status: ItemsStatus.loading));

    final result = await _getItems(NoParams());

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ItemsStatus.failure,
          failure: failure,
          message: _mapFailureToMessage(failure),
        ),
      ),
      (items) => emit(
        state.copyWith(
          status: ItemsStatus.success,
          items: items,
          hasReachedMax: items.length < _itemsPerPage,
        ),
      ),
    );
  }

  /// Handle loading more items (pagination)
  Future<void> _onLoadMoreItems(
    LoadMoreItemsEvent event,
    Emitter<ItemsState> emit,
  ) async {
    if (state.hasReachedMax) return;

    emit(state.copyWith(status: ItemsStatus.loadingMore));

    // For now, we'll simulate pagination by limiting the displayed items
    // In a real app, you'd pass pagination parameters to the use case
    final result = await _getItems(NoParams());

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ItemsStatus.failure,
          failure: failure,
          message: _mapFailureToMessage(failure),
        ),
      ),
      (allItems) {
        final currentLength = state.items.length;
        final newItems = allItems
            .skip(currentLength)
            .take(_itemsPerPage)
            .toList();

        final updatedItems = List.of(state.items)..addAll(newItems);

        emit(
          state.copyWith(
            status: ItemsStatus.success,
            items: updatedItems,
            hasReachedMax:
                newItems.length < _itemsPerPage ||
                updatedItems.length >= allItems.length,
          ),
        );
      },
    );
  }

  /// Map failure to user-friendly message
  String _mapFailureToMessage(Failure failure) {
    return switch (failure) {
      ServerFailure _ => 'Server error occurred. Please try again later.',
      NetworkFailure _ =>
        'No internet connection. Please check your connection.',
      CacheFailure _ => 'Unable to load cached data.',
      _ => 'An unexpected error occurred.',
    };
  }
}
