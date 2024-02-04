import 'package:background_location/background_location.dart';
import 'dart:async';

import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<void> initBackgroundLocation() async {
    await BackgroundLocation.startLocationService();
    await BackgroundLocation.setAndroidNotification(
      title: 'Location Tracking',
      message: 'Your location is being tracked in the background.',
      icon: '@mipmap/ic_launcher',
    );
  }

  Future<Location?> getLocation() async {
    try {
      Location location = await BackgroundLocation().getCurrentLocation();
      print('This is current Location ' + location.toMap().toString());
      return location;
    } catch (e) {
      print('Error getting location: $e');
      return null;
    }
  }
}
