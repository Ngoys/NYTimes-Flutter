import 'package:flutter/material.dart';
import 'package:nytimes/config/stylesheet/app_font.dart';
import 'package:nytimes/modal/article.dart';
import 'package:nytimes/utils/app_datetime_formatter.dart';

class ArticleItemWidget extends StatelessWidget {
  const ArticleItemWidget(this.article, {super.key});

  final Article article;

  @override
  Widget build(BuildContext context) {
    String? formattedDate;
    if (article.publishedDate != null) {
      formattedDate = article.publishedDate!
          .toRelativeDate('MMMM d, yyyy', context: context);
    }

    return Column(
      children: <Widget>[
        if (article.title != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(article.title ?? '',
                  maxLines: 3,
                  style: AppFont.bodyLarge
                      .copyWith(height: 1.2, letterSpacing: -0.3)),
            ),
          ),
        if (formattedDate != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                formattedDate,
                style:
                    AppFont.bodySmall.copyWith(fontSize: AppFont.font_size_r),
              ),
            ),
          ),
        const Divider(height: 0.5, color: Colors.grey),
      ],
    );
  }
}
