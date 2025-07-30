import 'package:equatable/equatable.dart';

/// Item entity representing the core business object
class Item extends Equatable {
  const Item({
    required this.id,
    required this.title,
    required this.timestamp,
    required this.tag,
    this.isFavorite = false,
  });

  final int id;
  final String title;
  final DateTime timestamp;
  final ItemTag tag;
  final bool isFavorite;

  /// Create a copy of this item with some fields replaced
  Item copyWith({
    int? id,
    String? title,
    DateTime? timestamp,
    ItemTag? tag,
    bool? isFavorite,
  }) {
    return Item(
      id: id ?? this.id,
      title: title ?? this.title,
      timestamp: timestamp ?? this.timestamp,
      tag: tag ?? this.tag,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object> get props => [id, title, timestamp, tag, isFavorite];
}

/// Enum representing different item tags
enum ItemTag {
  newTag('New'),
  old('Old'),
  hot('Hot');

  const ItemTag(this.displayName);
  final String displayName;
}
