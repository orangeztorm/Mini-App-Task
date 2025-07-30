// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) => ItemModel(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  timestamp: DateTime.parse(json['timestamp'] as String),
  tag: $enumDecode(_$ItemTagEnumMap, json['tag']),
  isFavorite: json['isFavorite'] as bool? ?? false,
);

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'timestamp': instance.timestamp.toIso8601String(),
  'tag': _$ItemTagEnumMap[instance.tag]!,
  'isFavorite': instance.isFavorite,
};

const _$ItemTagEnumMap = {
  ItemTag.newTag: 'newTag',
  ItemTag.old: 'old',
  ItemTag.hot: 'hot',
};
