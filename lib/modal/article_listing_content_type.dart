enum ArticleListingContentType {
  mostViewed,
  mostShared,
  mostEmailed,
}

extension ArticleListingContentTypeExtension on ArticleListingContentType {
  String get name {
    switch (this) {
      case ArticleListingContentType.mostViewed:
        return 'most_viewed';
      case ArticleListingContentType.mostShared:
        return 'most_shared';
      case ArticleListingContentType.mostEmailed:
        return 'most_emailed';
    }
  }
}
