import 'package:background_location/background_location.dart';
import 'dart:async';

class LocationService {
  Future<void> initBackgroundLocation() async {
    await BackgroundLocation.startLocationService();
    await BackgroundLocation.setAndroidNotification(
      title: 'Location Tracking',
      message: 'Your location is being tracked in the background.',
      icon: '@mipmap/ic_launcher',
    );

    BackgroundLocation.getLocationUpdates((location) {
      print('Location: ${location.latitude}, ${location.longitude}');
      // Do something with the location data
    });

    // You can also use other methods provided by the package, such as
    // BackgroundLocation.getLatestLocation()
    // BackgroundLocation.stopLocationService()
    // etc.
  }
}
