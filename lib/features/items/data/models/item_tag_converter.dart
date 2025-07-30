import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/item.dart';

/// JSON converter for ItemTag enum
class ItemTagConverter implements JsonConverter<ItemTag, String> {
  const ItemTagConverter();

  @override
  ItemTag fromJson(String json) {
    switch (json.toLowerCase()) {
      case 'new':
        return ItemTag.newTag;
      case 'old':
        return ItemTag.old;
      case 'hot':
        return ItemTag.hot;
      default:
        return ItemTag.newTag; // Default fallback
    }
  }

  @override
  String toJson(ItemTag object) {
    return object.displayName;
  }
}
