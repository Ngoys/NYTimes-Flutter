import 'package:flutter/material.dart';
import 'package:nytimes/utils/context_extension.dart';

enum ArticleListingContentType {
  mostViewed,
  mostShared,
  mostEmailed,
}

extension ArticleListingContentTypeExtension on ArticleListingContentType {
  String getName(BuildContext context) {
    switch (this) {
      case ArticleListingContentType.mostViewed:
        return '${context.localization.homeMenuMostViewedTitle} ${context.localization.article}';
      case ArticleListingContentType.mostShared:
        return '${context.localization.homeMenuMostSharedTitle} ${context.localization.article}';
      case ArticleListingContentType.mostEmailed:
        return '${context.localization.homeMenuMostEmailedTitle} ${context.localization.article}';
    }
  }
}
