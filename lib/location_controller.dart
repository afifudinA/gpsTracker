import 'package:geolocator/geolocator.dart';
import 'dart:async';

class LocationService {
  Future<void> initializeLocationService() async {
    if (!(await Geolocator.isLocationServiceEnabled())) {
      throw Exception('Location services are disabled.');
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }

  Future<Position> determinePosition() async {
    return await Geolocator.getCurrentPosition();
  }
}
