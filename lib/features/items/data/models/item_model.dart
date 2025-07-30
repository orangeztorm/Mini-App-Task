import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/item.dart';
import 'item_tag_converter.dart';

part 'item_model.g.dart';

/// Data model for Item with JSON serialization
@JsonSerializable()
class ItemModel extends Item {
  const ItemModel({
    required super.id,
    required super.title,
    required super.timestamp,
    @ItemTagConverter() required super.tag,
    super.isFavorite,
  });

  /// Create ItemModel from JSON
  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  /// Convert ItemModel to JSON
  Map<String, dynamic> toJson() => _$ItemModelToJson(this);

  /// Create ItemModel from API response (mock transformation)
  factory ItemModel.fromApiResponse(Map<String, dynamic> json) {
    // Mock transformation from API response to our model
    return ItemModel(
      id: json['id'] as int,
      title: json['title'] as String,
      timestamp: DateTime.now().subtract(
        Duration(days: (json['id'] as int) % 30), // Mock timestamp based on ID
      ),
      tag: _getRandomTag(json['id'] as int), // Mock tag assignment
      isFavorite: false,
    );
  }

  /// Convert to domain entity
  Item toEntity() {
    return Item(
      id: id,
      title: title,
      timestamp: timestamp,
      tag: tag,
      isFavorite: isFavorite,
    );
  }

  /// Create ItemModel from domain entity
  factory ItemModel.fromEntity(Item item) {
    return ItemModel(
      id: item.id,
      title: item.title,
      timestamp: item.timestamp,
      tag: item.tag,
      isFavorite: item.isFavorite,
    );
  }

  /// Get random tag based on ID for mock data
  static ItemTag _getRandomTag(int id) {
    final tags = ItemTag.values;
    return tags[id % tags.length];
  }

  @override
  ItemModel copyWith({
    int? id,
    String? title,
    DateTime? timestamp,
    ItemTag? tag,
    bool? isFavorite,
  }) {
    return ItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      timestamp: timestamp ?? this.timestamp,
      tag: tag ?? this.tag,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
