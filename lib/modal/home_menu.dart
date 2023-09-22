enum HomeMenu {
  searchArticle,
  mostViewed,
  mostShared,
  mostEmailed,
  location,
}

extension HomeMenuExtension on HomeMenu {
  String get name {
    switch (this) {
      case HomeMenu.searchArticle:
        return 'Search Articles';

      case HomeMenu.mostViewed:
        return 'Most Viewed';

      case HomeMenu.mostShared:
        return 'Most Shared';

      case HomeMenu.mostEmailed:
        return 'Most Emailed';

      case HomeMenu.location:
        return 'Location';
    }
  }
}
