import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../models/item_model.dart';
import 'item_local_data_source.dart';
import 'mock_data_service.dart';

/// Implementation of [ItemLocalDataSource] using SharedPreferences
@Injectable(as: ItemLocalDataSource)
class ItemLocalDataSourceImpl implements ItemLocalDataSource {
  const ItemLocalDataSourceImpl(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  @override
  Future<List<ItemModel>> getCachedItems() async {
    try {
      final jsonString = _sharedPreferences.getString(
        AppConstants.cachedItemsKey,
      );
      if (jsonString == null) {
        // Return mock data if no cached data exists
        final mockItems = MockDataService.getMockItems();
        // Cache the mock data for future use
        await cacheItems(mockItems);
        return mockItems;
      }

      final List<dynamic> jsonData = json.decode(jsonString);
      final favoriteIds = await getFavoriteItemIds();

      return jsonData.map((json) {
        final item = ItemModel.fromJson(json as Map<String, dynamic>);
        return item.copyWith(isFavorite: favoriteIds.contains(item.id));
      }).toList();
    } catch (e) {
      // Return mock data on any error
      return MockDataService.getMockItems();
    }
  }

  @override
  Future<void> cacheItems(List<ItemModel> items) async {
    try {
      final jsonString = json.encode(
        items.map((item) => item.toJson()).toList(),
      );
      final result = await _sharedPreferences.setString(
        AppConstants.cachedItemsKey,
        jsonString,
      );

      if (!result) {
        throw const CacheException('Failed to cache items');
      }
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheException('Failed to cache items: $e');
    }
  }

  @override
  Future<void> toggleFavorite(int itemId) async {
    try {
      final favoriteIds = await getFavoriteItemIds();

      if (favoriteIds.contains(itemId)) {
        favoriteIds.remove(itemId);
      } else {
        favoriteIds.add(itemId);
      }

      final result = await _sharedPreferences.setStringList(
        AppConstants.favoriteItemsKey,
        favoriteIds.map((id) => id.toString()).toList(),
      );

      if (!result) {
        throw const CacheException('Failed to toggle favorite');
      }
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheException('Failed to toggle favorite: $e');
    }
  }

  @override
  Future<List<int>> getFavoriteItemIds() async {
    try {
      final favoriteIdStrings =
          _sharedPreferences.getStringList(AppConstants.favoriteItemsKey) ?? [];

      return favoriteIdStrings
          .map((idString) => int.tryParse(idString))
          .whereType<int>()
          .toList();
    } catch (e) {
      // Return empty list instead of throwing for favorites
      return [];
    }
  }
}
