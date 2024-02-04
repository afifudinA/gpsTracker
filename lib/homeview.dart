import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:gps_tracker/background_service.dart';
import 'settings.dart';
import 'package:background_location/background_location.dart';

Location? locationStart = locationNow;
double? latitude = locationStart?.latitude;
double? longitude = locationStart?.longitude;

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
      appBar: AppBar(
        title: Text("GPS Tracker"),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert), // Three dots icon
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SettingsPage()),
                      );
                    },
                    child: Text("Settings"),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
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
                locationStart = locationNow;
                latitude = locationStart?.latitude;
                longitude = locationStart?.longitude;
                setState(() {});
              },
              child: Text(text),
            ),
            SizedBox(height: 20),
            Text("Longitude: ${longitude.toString()}"),
          ],
        ),
      ),
    );
  }
}
