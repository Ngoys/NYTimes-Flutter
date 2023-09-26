import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nytimes/config/stylesheet/app_font.dart';
import 'package:nytimes/modal/document_article.dart';
import 'package:nytimes/state/network/network_cubit.dart';
import 'package:nytimes/state/network/network_state.dart';
import 'package:nytimes/state/search/search_cubit.dart';
import 'package:nytimes/state/search/search_state.dart';
import 'package:nytimes/utils/constants.dart';
import 'package:nytimes/utils/context_extension.dart';
import 'package:nytimes/widget/app_safe_area.dart';
import 'package:nytimes/widget/document_article_item_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  static const String route = '/search';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final SearchCubit _searchCubit;
  late final NetworkCubit _networkCubit;
  late final ScrollController _scrollController;
  late final TextEditingController _textEditingController;
  Timer? _searchDebounce;

  @override
  void initState() {
    super.initState();

    _networkCubit = BlocProvider.of<NetworkCubit>(context);
    _searchCubit = BlocProvider.of<SearchCubit>(context);

    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.75) {
          _searchCubit.loadMoreDocumentArticle();
        }
      });

    _textEditingController = TextEditingController()
      ..addListener(() {
        _searchCubit.updateKeyword(_textEditingController.text);

        if (_searchDebounce?.isActive ?? false) _searchDebounce?.cancel();
        _searchDebounce = Timer(const Duration(milliseconds: 500), () {
          if (_textEditingController.text.length >= 3) {
            _searchCubit.startSearchDocumentArticle();
          }
        });
      });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _scrollController.dispose();
    _searchDebounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.localization.search,
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: BlocConsumer<SearchCubit, SearchState>(
          listener: (BuildContext context, SearchState state) {
            if (state is SearchErrorState) {
              context.appOverlay?.showAlertDialog(
                context: context,
                title: (state.failureResponse.code == tooManyRequestError)
                    ? context.localization.labelTooManyRequest
                    : context.localization.labelSomethingWentWrong,
                body: context.localization.labelPleaseTryAgain,
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      context.appOverlay?.hideAlertDialog();
                    },
                    style: AppFont.buttonMedium,
                    child: Text(context.localization.ok.toUpperCase()),
                  )
                ],
              );
            }
          },
          builder: (BuildContext context, SearchState state) {
            return AppSafeArea(
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                        child: SizedBox(
                          height: 50,
                          child: TextField(
                            controller: _textEditingController,
                            autofocus: true,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              label: Text(
                                context.localization.searchPlaceholder,
                                style: AppFont.regular,
                              ),
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          padding: const EdgeInsets.only(top: 12),
                          itemCount: _searchCubit.getDocumentArticles().length +
                              (_networkCubit.state is NetworkConnectedState &&
                                      state is SearchLoadingNextPageState
                                  ? 1
                                  : 0),
                          itemBuilder: (BuildContext context, int index) {
                            if (index ==
                                _searchCubit.getDocumentArticles().length) {
                              return const Padding(
                                padding: EdgeInsets.all(20),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            } else {
                              final DocumentArticle documentArticle =
                                  _searchCubit.getDocumentArticles()[index];
                              return DocumentArticleItemWidget(documentArticle);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  if (state is SearchLoadingState)
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
