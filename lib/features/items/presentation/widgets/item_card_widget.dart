import 'package:flutter/material.dart';

import '../../domain/entities/item.dart';

/// Widget for displaying an individual item card
class ItemCardWidget extends StatelessWidget {
  const ItemCardWidget({
    super.key,
    required this.item,
    required this.onFavoriteToggle,
  });

  final Item item;
  final VoidCallback onFavoriteToggle;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    item.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: item.isFavorite ? Colors.red : Colors.grey,
                  ),
                  onPressed: onFavoriteToggle,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildTag(context, item.tag),
                const Spacer(),
                _buildTimestamp(context, item.timestamp),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(BuildContext context, ItemTag tag) {
    Color tagColor;
    switch (tag) {
      case ItemTag.newTag:
        tagColor = Colors.green;
        break;
      case ItemTag.hot:
        tagColor = Colors.orange;
        break;
      case ItemTag.old:
        tagColor = Colors.grey;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: tagColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tagColor.withValues(alpha: 0.3)),
      ),
      child: Text(
        tag.displayName,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: tagColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildTimestamp(BuildContext context, DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    String timeAgo;
    if (difference.inDays > 0) {
      timeAgo = '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      timeAgo = '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      timeAgo = '${difference.inMinutes}m ago';
    } else {
      timeAgo = 'Just now';
    }

    return Row(
      children: [
        Icon(
          Icons.access_time,
          size: 16,
          color: Theme.of(context).disabledColor,
        ),
        const SizedBox(width: 4),
        Text(
          timeAgo,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).disabledColor,
          ),
        ),
      ],
    );
  }
}
