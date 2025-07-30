// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i161;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../core/network/network_info.dart' as _i6;
import '../core/network/network_info_impl.dart' as _i927;
import '../features/items/data/datasources/item_local_data_source.dart'
    as _i973;
import '../features/items/data/datasources/item_local_data_source_impl.dart'
    as _i626;
import '../features/items/data/datasources/item_remote_data_source.dart'
    as _i565;
import '../features/items/data/datasources/item_remote_data_source_impl.dart'
    as _i486;
import '../features/items/data/repositories/item_repository_impl.dart' as _i702;
import '../features/items/domain/repositories/item_repository.dart' as _i553;
import '../features/items/domain/usecases/get_favorite_item_ids.dart' as _i909;
import '../features/items/domain/usecases/get_items.dart' as _i383;
import '../features/items/domain/usecases/toggle_favorite.dart' as _i81;
import '../features/items/presentation/bloc/favorite/favorite_bloc.dart'
    as _i230;
import '../features/items/presentation/bloc/items/items_bloc.dart' as _i1051;
import '../features/items/presentation/bloc/search/search_bloc.dart' as _i114;
import 'injection_container.dart' as _i809;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.factory<_i114.SearchBloc>(() => _i114.SearchBloc());
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i161.InternetConnection>(
      () => registerModule.internetConnection,
    );
    gh.factory<_i973.ItemLocalDataSource>(
      () => _i626.ItemLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i565.ItemRemoteDataSource>(
      () => _i486.ItemRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.factory<_i6.NetworkInfo>(
      () => _i927.NetworkInfoImpl(gh<_i161.InternetConnection>()),
    );
    gh.factory<_i553.ItemRepository>(
      () => _i702.ItemRepositoryImpl(
        remoteDataSource: gh<_i565.ItemRemoteDataSource>(),
        localDataSource: gh<_i973.ItemLocalDataSource>(),
        networkInfo: gh<_i6.NetworkInfo>(),
      ),
    );
    gh.factory<_i383.GetItems>(
      () => _i383.GetItems(gh<_i553.ItemRepository>()),
    );
    gh.factory<_i81.ToggleFavorite>(
      () => _i81.ToggleFavorite(gh<_i553.ItemRepository>()),
    );
    gh.factory<_i909.GetFavoriteItemIds>(
      () => _i909.GetFavoriteItemIds(gh<_i553.ItemRepository>()),
    );
    gh.factory<_i230.FavoriteBloc>(
      () => _i230.FavoriteBloc(
        gh<_i909.GetFavoriteItemIds>(),
        gh<_i81.ToggleFavorite>(),
      ),
    );
    gh.factory<_i1051.ItemsBloc>(() => _i1051.ItemsBloc(gh<_i383.GetItems>()));
    return this;
  }
}

class _$RegisterModule extends _i809.RegisterModule {}
