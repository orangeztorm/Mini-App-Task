import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/items/items.dart';
import '../bloc/search/search.dart';

/// Widget for searching items by title
class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    final itemsState = context.read<ItemsBloc>().state;

    if (itemsState.status.isSuccess) {
      context.read<SearchBloc>().add(
        SearchItemsEvent(query: query, allItems: itemsState.items),
      );
    }
  }

  void _clearSearch() {
    _searchController.clear();
    context.read<SearchBloc>().add(const ClearSearchEvent());
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: TextField(
        controller: _searchController,
        focusNode: _focusNode,
        decoration: InputDecoration(
          hintText: 'Search items by title...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state.query.isNotEmpty) {
                return IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: _clearSearch,
                );
              }
              return const SizedBox.shrink();
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Theme.of(context).dividerColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
          ),
          filled: true,
          fillColor: Theme.of(context).cardColor,
        ),
        onChanged: _onSearchChanged,
        textInputAction: TextInputAction.search,
      ),
    );
  }
}
