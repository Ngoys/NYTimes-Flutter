import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nytimes/modal/article.dart';
import 'package:nytimes/modal/article_listing_content_type.dart';
import 'package:nytimes/modal/failure_response.dart';
import 'package:nytimes/service/article_store.dart';
import 'package:nytimes/state/network/network_state.dart';

class NetworkCubit extends Cubit<NetworkState> {
  NetworkCubit({required ArticleStore articleStore})
      : _articleStore = articleStore,
        super(const UnknownNetworkState()) {
    connectivityStreamSubscription = _connectivity.onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) async {
      if (connectivityResult == ConnectivityResult.none) {
        emit(const NetworkDisconnectedState());
      } else {
        if (state is! UnknownNetworkState) {
          final Either<FailureResponse, List<Article>> result =
              await _articleStore
                  .fetchArticles(ArticleListingContentType.mostEmailed);
          result.fold<void>(
            (FailureResponse failureResponse) =>
                emit(const NetworkDisconnectedState()),
            (List<Article> inspection) => emit(const NetworkConnectedState()),
          );
        } else {
          emit(const NetworkConnectedState());
        }
      }
    });
  }

  final ArticleStore _articleStore;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> connectivityStreamSubscription;

  Future<void> notifyOfCurrentNetworkStatusWhenDisconnected() async {
    final ConnectivityResult result = await _connectivity.checkConnectivity();
    if (result == ConnectivityResult.none) {
      emit(const NetworkDisconnectedState());
    } else {
      emit(const NetworkConnectedState());
    }
  }

  @override
  Future<void> close() async {
    await connectivityStreamSubscription.cancel();
    return super.close();
  }
}
