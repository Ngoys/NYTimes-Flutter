import 'package:equatable/equatable.dart';
import 'package:nytimes/modal/article.dart';
import 'package:nytimes/modal/document_article.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => <Object?>[];
}

class SearchInitialState extends SearchState {
  const SearchInitialState();
}

class SearchLoadingState extends SearchState {
  const SearchLoadingState();
}

class SearchLoadingNextPageState extends SearchState {
  const SearchLoadingNextPageState();
}

class SearchLoadedState extends SearchState {
  const SearchLoadedState(this.documentArticles);

  final List<DocumentArticle> documentArticles;

  @override
  List<Object> get props => <Object>[documentArticles];
}

class SearchErrorState extends SearchState {
  const SearchErrorState();
}
