import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nytimes/state/location/location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(const UnknownLocationState());

  StreamSubscription<Position>? positionStream;
  StreamSubscription<ServiceStatus>? serviceStatusStream;

  Future<Position> getCurrentLocation() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  void subscribeToLocationUpdate() {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.best,
    );
    positionStream ??=
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      if (position != null) {
        emit(LocationLoadedState(position));
      }
    });
  }

  void subscribeToLocationServiceChange() {
    serviceStatusStream ??=
        Geolocator.getServiceStatusStream().listen((ServiceStatus event) {
      switch (event) {
        case ServiceStatus.disabled:
          emit(const LocationDisabledState());
          break;
        case ServiceStatus.enabled:
          subscribeToLocationUpdate();
          break;
      }
    });
  }

  Future<bool> isLocationServiceEnabled() async {
    return Geolocator.isLocationServiceEnabled();
  }

  Future<void> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    switch (permission) {
      case LocationPermission.denied:
        permission = await Geolocator.requestPermission();
        break;
      case LocationPermission.deniedForever:
        emit(const LocationDisabledState());
        break;
      default:
        break;
    }
  }

  Future<bool> openLocationSettings() async {
    return Geolocator.openLocationSettings();
  }

  @override
  Future<void> close() async {
    await positionStream?.cancel();
    positionStream = null;
    await serviceStatusStream?.cancel();
    serviceStatusStream = null;

    return super.close();
  }
}
