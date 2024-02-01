import 'package:flutter/material.dart';
import 'package:gps_tracker/background_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'homeview.dart';
import 'location_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.notification.isDenied.then(
    (value) {
      if (value) {
        Permission.notification.request();
      }
    },
  );
  await LocationService().initializeLocationService();
  await initializeService();
  runApp(const myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Background Service',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}
