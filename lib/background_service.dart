import 'dart:async';
import 'dart:ui';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:geolocator/geolocator.dart';
import 'location_controller.dart';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
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
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) {
  DartPluginRegistrant.ensureInitialized();
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
      print("Something");
    });
    service.on('setAsbackground').listen((event) {
      service.setAsBackgroundService();
    });
  }
  service.on('stopService').listen((event) {
    service.stopSelf();
  });
  print("Background Process Is working");
  service.invoke('update');
}
