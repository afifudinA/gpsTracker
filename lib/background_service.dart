//background_service.dart

import 'dart:async';
import 'dart:ui';
import 'package:background_location/background_location.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:geolocator/geolocator.dart';
import 'location_controller.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

int repeateTimer = 5;
Location? locationNow;

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  try {
    LocationService().initBackgroundLocation();
    await service.configure(
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: onStart,
      ),
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        isForegroundMode: true,
      ),
    );
  } catch (e) {
    print("Error configuring background service: $e");
  }
}

// background_service.dart
@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsbackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  Timer.periodic(Duration(seconds: repeateTimer), (timer) async {
    try {
      locationNow = await LocationService().getLocation(); // Await the result
      print("Repeating print every $repeateTimer seconds");
      print(
          "Location Now = Latitude ${locationNow?.latitude}, longitude ${locationNow?.longitude}");
    } catch (e) {
      print("Error getting location: $e");
    }
  });

  service.invoke('update');
}
