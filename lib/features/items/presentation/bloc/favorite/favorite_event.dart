import 'package:equatable/equatable.dart';

/// Base class for all favorite events
abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

/// Event to load favorite item IDs
class LoadFavoritesEvent extends FavoriteEvent {
  const LoadFavoritesEvent();
}

/// Event to toggle favorite status of an item
class ToggleFavoriteEvent extends FavoriteEvent {
  const ToggleFavoriteEvent({required this.itemId});

  final int itemId;

  @override
  List<Object> get props => [itemId];
}
