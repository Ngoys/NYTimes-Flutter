import 'package:equatable/equatable.dart';

abstract class NetworkState extends Equatable {
  const NetworkState();

  @override
  List<Object?> get props => <Object?>[];
}

class UnknownNetworkState extends NetworkState {
  const UnknownNetworkState();
}

class NetworkConnectedState extends NetworkState {
  const NetworkConnectedState();
}

class NetworkDisconnectedState extends NetworkState {
  const NetworkDisconnectedState();
}

class ServerUnreachableState extends NetworkState {
  const ServerUnreachableState();
}
