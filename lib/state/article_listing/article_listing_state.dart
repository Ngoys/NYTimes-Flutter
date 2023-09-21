import 'package:equatable/equatable.dart';
import 'package:nytimes/modal/article.dart';

abstract class ArticleListingState extends Equatable {
  const ArticleListingState();

  @override
  List<Object?> get props => <Object?>[];
}

class ArticleListingInitialState extends ArticleListingState {
  const ArticleListingInitialState();
}

class ArticleListingLoadingState extends ArticleListingState {
  const ArticleListingLoadingState();
}

class ArticleListingLoadedState extends ArticleListingState {
  const ArticleListingLoadedState(this.articles);

  final List<Article> articles;

  @override
  List<Object> get props => <Object>[articles];
}

class ArticleListingErrorState extends ArticleListingState {
  const ArticleListingErrorState();
}
