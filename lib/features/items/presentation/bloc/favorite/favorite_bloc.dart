import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecases/get_favorite_item_ids.dart';
import '../../../domain/usecases/toggle_favorite.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/error/failures.dart';
import 'favorite_event.dart';
import 'favorite_state.dart';

/// BLoC responsible for managing favorite items state
@injectable
class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc(this._getFavoriteItemIds, this._toggleFavorite)
    : super(FavoriteState.initial()) {
    on<LoadFavoritesEvent>(_onLoadFavorites);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
  }

  final GetFavoriteItemIds _getFavoriteItemIds;
  final ToggleFavorite _toggleFavorite;

  /// Handle loading favorite item IDs
  Future<void> _onLoadFavorites(
    LoadFavoritesEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(state.copyWith(status: FavoriteStatus.loading));

    final result = await _getFavoriteItemIds(NoParams());

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: FavoriteStatus.failure,
          failure: failure,
          message: _mapFailureToMessage(failure),
        ),
      ),
      (favoriteIds) => emit(
        state.copyWith(
          status: FavoriteStatus.success,
          favoriteIds: favoriteIds,
        ),
      ),
    );
  }

  /// Handle toggling favorite status
  Future<void> _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    // Optimistically update the UI immediately
    final currentFavorites = List<int>.from(state.favoriteIds);
    final isCurrentlyFavorite = currentFavorites.contains(event.itemId);
    
    if (isCurrentlyFavorite) {
      currentFavorites.remove(event.itemId);
    } else {
      currentFavorites.add(event.itemId);
    }
    
    // Emit the optimistic update immediately
    emit(state.copyWith(
      status: FavoriteStatus.success,
      favoriteIds: currentFavorites,
    ));

    // Then perform the actual toggle operation in the background
    final result = await _toggleFavorite(
      ToggleFavoriteParams(itemId: event.itemId),
    );

    result.fold(
      (failure) {
        // If the operation failed, revert the optimistic update
        emit(state.copyWith(
          status: FavoriteStatus.failure,
          failure: failure,
          message: _mapFailureToMessage(failure),
          favoriteIds: state.favoriteIds, // Revert to previous state
        ));
        
        // Then reload the actual state from storage
        _onLoadFavorites(const LoadFavoritesEvent(), emit);
      },
      (_) {
        // Success - the optimistic update was correct, no need to change anything
        // But let's confirm by reloading from storage to ensure consistency
        _getFavoriteItemIds(NoParams()).then((favoritesResult) {
          favoritesResult.fold(
            (failure) => null, // Ignore failure in confirmation
            (favoriteIds) => emit(state.copyWith(
              status: FavoriteStatus.success,
              favoriteIds: favoriteIds,
            )),
          );
        });
      },
    );
  }

  /// Map failure to user-friendly message
  String _mapFailureToMessage(Failure failure) {
    return switch (failure) {
      ServerFailure _ => 'Server error occurred. Please try again later.',
      NetworkFailure _ =>
        'No internet connection. Please check your connection.',
      CacheFailure _ => 'Unable to save favorite. Please try again.',
      _ => 'An unexpected error occurred.',
    };
  }
}
