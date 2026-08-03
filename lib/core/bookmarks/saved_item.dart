enum SavedItemType { restaurant, food, menuItem, cafe, discovery, scannedDish }

class SavedItem {
  const SavedItem({
    required this.id,
    required this.type,
    required this.title,
    required this.savedAt,
    this.subtitle,
    this.imageAsset,
  });

  final String id;
  final SavedItemType type;
  final String title;
  final String? subtitle;
  final String? imageAsset;
  final DateTime savedAt;
}

enum SavedItemFilter { all, restaurants, foods, menuItems }
