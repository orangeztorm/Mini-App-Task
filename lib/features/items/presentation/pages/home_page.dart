import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container/injection_container.dart';
import '../bloc/favorite/favorite.dart';
import '../bloc/items/items.dart';
import '../bloc/search/search.dart';
import '../widgets/items_list_widget.dart';
import '../widgets/search_widget.dart';

/// Home page displaying the list of items with search and favorites
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ItemsBloc>(
          create: (context) => sl<ItemsBloc>()..add(const LoadItemsEvent()),
        ),
        BlocProvider<FavoriteBloc>(
          create: (context) =>
              sl<FavoriteBloc>()..add(const LoadFavoritesEvent()),
        ),
        BlocProvider<SearchBloc>(create: (context) => sl<SearchBloc>()),
      ],
      child: const HomeView(),
    );
  }
}

/// Home view with app bar and body
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini App Task'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        elevation: 2,
        actions: [
          BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, state) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.favorite),
                    onPressed: () {
                      // Navigate to favorites page (optional feature)
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${state.favoriteCount} favorite items',
                          ),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                  if (state.favoriteCount > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                        ),
                        child: Text(
                          '${state.favoriteCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SearchWidget(),
          Expanded(child: ItemsListWidget()),
        ],
      ),
    );
  }
}
