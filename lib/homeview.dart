import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'location_controller.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String text = "Stop Service";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final service = FlutterBackgroundService();
                bool isRunning = await service.isRunning();
                if (isRunning) {
                  service.invoke("stopService");
                } else {
                  service.startService();
                }

                if (!isRunning) {
                  text = "Stop Service";
                } else {
                  text = "Start Service";
                }
                setState(() {});
              },
              child: Text(text),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
