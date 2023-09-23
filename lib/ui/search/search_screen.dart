import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nytimes/config/stylesheet/app_font.dart';
import 'package:nytimes/modal/article.dart';
import 'package:nytimes/modal/article_listing_content_type.dart';
import 'package:nytimes/state/article_listing/article_listing_cubit.dart';
import 'package:nytimes/state/article_listing/article_listing_state.dart';
import 'package:nytimes/utils/app_datetime_formatter.dart';
import 'package:nytimes/utils/constants.dart';
import 'package:nytimes/utils/context_extension.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  static const String route = '/article_listing';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final SearchCubit _searchCubit;

  @override
  void initState() {
    super.initState();

    _searchCubit = BlocProvider.of<SearchCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _articleListingContentType.getName(context),
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
      body: BlocConsumer<SearchCubit, SearchState>(
        listener: (BuildContext context, SearchState state) {
          if (state is SearchErrorState) {
            context.appOverlay?.showAlertDialog(
                context: context,
                title: context.localization.labelSomethingWentWrong,
                body: context.localization.labelPleaseTryAgain);
          }
        },
        builder: (BuildContext context, SearchState state) {
          if (state is SearchLoadedState) {
            return Scrollbar(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 12),
                itemCount: state.articles.length,
                itemBuilder: (BuildContext context, int index) {
                  final Article article = state.articles[index];

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
                                style: AppFont.bodyLarge.copyWith(
                                    height: 1.2, letterSpacing: -0.3)),
                          ),
                        ),
                      if (formattedDate != null)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              formattedDate,
                              style: AppFont.bodySmall
                                  .copyWith(fontSize: AppFont.font_size_r),
                            ),
                          ),
                        ),
                      const Divider(height: 0.5, color: Colors.grey),
                    ],
                  );
                },
              ),
            );
          } else if (state is SearchLoadingState) {
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
