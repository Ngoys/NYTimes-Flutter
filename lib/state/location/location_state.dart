import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object?> get props => <Object?>[];
}

class UnknownLocationState extends LocationState {
  const UnknownLocationState();
}

class LocationLoadedState extends LocationState {
  const LocationLoadedState(this.position);

  final Position position;

  @override
  List<Object> get props => <Object>[position];
}

class LocationDisabledState extends LocationState {
  const LocationDisabledState();
}
