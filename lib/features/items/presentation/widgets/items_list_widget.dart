import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/favorite/favorite.dart';
import '../bloc/items/items.dart';
import '../bloc/search/search.dart';
import 'item_card_widget.dart';

/// Widget displaying the list of items
class ItemsListWidget extends StatefulWidget {
  const ItemsListWidget({super.key});

  @override
  State<ItemsListWidget> createState() => _ItemsListWidgetState();
}

class _ItemsListWidgetState extends State<ItemsListWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<ItemsBloc>().add(const LoadMoreItemsEvent());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, searchState) {
        // Show search results if searching
        if (searchState.status.isSuccess || searchState.status.isEmpty) {
          return _buildSearchResults(searchState);
        }

        // Show all items if not searching
        return BlocBuilder<ItemsBloc, ItemsState>(
          builder: (context, itemsState) {
            return _buildItemsList(itemsState);
          },
        );
      },
    );
  }

  Widget _buildSearchResults(SearchState searchState) {
    if (searchState.status.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Theme.of(context).disabledColor,
            ),
            const SizedBox(height: 16),
            Text(
              searchState.message ?? 'No items found',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).disabledColor,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: searchState.filteredItems.length,
      itemBuilder: (context, index) {
        final item = searchState.filteredItems[index];
        return BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, favoriteState) {
            final isFavorite = favoriteState.isFavorite(item.id);
            return ItemCardWidget(
              item: item.copyWith(isFavorite: isFavorite),
              onFavoriteToggle: () {
                context.read<FavoriteBloc>().add(
                  ToggleFavoriteEvent(itemId: item.id),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildItemsList(ItemsState itemsState) {
    if (itemsState.status.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (itemsState.status.isFailure) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              itemsState.message ?? 'An error occurred',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                context.read<ItemsBloc>().add(const RefreshItemsEvent());
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (itemsState.items.isEmpty) {
      return const Center(child: Text('No items available'));
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<ItemsBloc>().add(const RefreshItemsEvent());
        // Wait for the refresh to complete
        await context.read<ItemsBloc>().stream.firstWhere(
          (state) => !state.status.isLoading,
        );
      },
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        itemCount: itemsState.hasReachedMax
            ? itemsState.items.length
            : itemsState.items.length + 1,
        itemBuilder: (context, index) {
          if (index >= itemsState.items.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final item = itemsState.items[index];
          return BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, favoriteState) {
              final isFavorite = favoriteState.isFavorite(item.id);
              return ItemCardWidget(
                item: item.copyWith(isFavorite: isFavorite),
                onFavoriteToggle: () {
                  context.read<FavoriteBloc>().add(
                    ToggleFavoriteEvent(itemId: item.id),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
