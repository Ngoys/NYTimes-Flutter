import 'dart:async';
import 'dart:developer' as developer;
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:nytimes/modal/location_statue.dart';

@lazySingleton
class GeoLocationStore {
  StreamSubscription<Position>? _positionStream;
  Position? _position;

  Future<void> init() async {
    try {
      final Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      _position = position;
    } on Exception catch (e) {
      developer.log(e.toString());
    }
  }

  Position getCurrentLocation() => _position!;

  Future<Position> waitAndGetCurrentLocation() async {
    if (_position != null) return _position!;
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  void subscribeToLocationUpdate() {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.best,
    );
    _positionStream ??=
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      if (position != null) {
        _position = position;
      }
    });
  }

  Stream<LocationStatus> subscribeToLocationServiceChange() {
    return Geolocator.getServiceStatusStream().transform(
        StreamTransformer<ServiceStatus, LocationStatus>.fromHandlers(
            handleData:
                (ServiceStatus serviceStatus, EventSink<LocationStatus> sink) {
      switch (serviceStatus) {
        case ServiceStatus.disabled:
          sink.add(LocationStatus.disabled);
          break;
        case ServiceStatus.enabled:
          sink.add(LocationStatus.enabled);
          break;
      }
    }));
  }

  Future<bool> isLocationServiceEnabled() async {
    return Geolocator.isLocationServiceEnabled();
  }

  Future<bool> openLocationSettings() async {
    return Geolocator.openLocationSettings();
  }

  Future<void> close() async {
    await _positionStream?.cancel();
    _positionStream = null;
  }
}
