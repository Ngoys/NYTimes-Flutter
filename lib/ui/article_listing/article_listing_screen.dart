import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nytimes/config/stylesheet/app_font.dart';
import 'package:nytimes/modal/article.dart';
import 'package:nytimes/modal/article_listing_content_type.dart';
import 'package:nytimes/state/article_listing/article_listing_cubit.dart';
import 'package:nytimes/state/article_listing/article_listing_state.dart';
import 'package:nytimes/utils/constants.dart';
import 'package:nytimes/utils/context_extension.dart';
import 'package:nytimes/widget/article_item_widget.dart';

class ArticleListingScreen extends StatefulWidget {
  const ArticleListingScreen({super.key});

  static const String route = '/article_listing';

  @override
  State<ArticleListingScreen> createState() => _ArticleListingScreenState();
}

class _ArticleListingScreenState extends State<ArticleListingScreen> {
  late final ArticleListingCubit _articleListingCubit;

  late ArticleListingContentType _articleListingContentType;

  @override
  void initState() {
    super.initState();

    _articleListingCubit = BlocProvider.of<ArticleListingCubit>(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      _articleListingContentType = arguments[NAV_ARTICLE_LISTING_CONTENT_TYPE];
      _articleListingCubit.fetchArticleListings(_articleListingContentType);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _articleListingContentType.getTitle(context),
          style: AppFont.titleLarge,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.5),
          child: Container(
            color: Colors.grey,
            height: 0.5,
          ),
        ),
      ),
      body: BlocConsumer<ArticleListingCubit, ArticleListingState>(
        listener: (BuildContext context, ArticleListingState state) {
          if (state is ArticleListingErrorState) {
            context.appOverlay?.showAlertDialog(
                context: context,
                title: context.localization.labelSomethingWentWrong,
                body: context.localization.labelPleaseTryAgain);
          }
        },
        builder: (BuildContext context, ArticleListingState state) {
          if (state is ArticleListingLoadedState) {
            return Scrollbar(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 12),
                itemCount: state.articles.length,
                itemBuilder: (BuildContext context, int index) {
                  final Article article = state.articles[index];
                  return ArticleItemWidget(article);
                },
              ),
            );
          } else if (state is ArticleListingLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container();
        },
      ),
    );
  }
}
