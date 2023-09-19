import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nytimes/state/network/network_state.dart';

class NetworkCubit extends Cubit<NetworkState> {
  NetworkCubit() : super(const UnknownNetworkState()) {
    connectivityStreamSubscription = _connectivity.onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) async {
      if (connectivityResult == ConnectivityResult.none) {
        emitNetworkDisconnectedState();
      } else {
        if (state is! UnknownNetworkState) {
          await GetIt.instance<CheckApiStatusUseCase>()(
            isConnected: () {
              emitNetworkConnectedState();
            },
            isServerNotReachable: () {
              emitServerUnreachableState();
            },
          );
        } else {
          emitNetworkConnectedState();
        }
      }
    });
  }

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> connectivityStreamSubscription;

  Future<void> notifyOfCurrentNetworkStatusWhenDisconnected() async {
    final ConnectivityResult result = await _connectivity.checkConnectivity();
    if (result == ConnectivityResult.none) {
      emitNetworkDisconnectedState();
    } else {
      emitNetworkConnectedState();
    }
  }

  void emitNetworkConnectedState() => emit(const NetworkConnectedState());

  void emitNetworkDisconnectedState() => emit(const NetworkDisconnectedState());

  void emitServerUnreachableState() => emit(const ServerUnreachableState());

  @override
  Future<void> close() async {
    await connectivityStreamSubscription.cancel();
    return super.close();
  }
}
