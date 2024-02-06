import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'background_service.dart';
import 'settings.dart';
import 'sharedData.dart';
import 'package:background_location/background_location.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String text = "Start Service";
  Location? locationStart;

  @override
  void initState() {
    super.initState();
    startBackgroundService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GPS Tracker"),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: InkWell(
                    onTap: () async {
                      // Navigate to SettingsPage and wait for result
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingsPage(
                            onBusIdChanged: (newBusId) {
                              // Update the busId in SharedData when it changes
                              SharedData().updateBusId(newBusId);
                            },
                          ),
                        ),
                      );

                      // Check if result is not null and handle it if needed
                      if (result != null) {
                        print("Result from SettingsPage: $result");
                      }
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
                // Toggle the background service
                toggleBackgroundService();
              },
              child: Text(text),
            ),
            SizedBox(height: 20),
            Text("Longitude: ${locationStart?.longitude ?? 'N/A'}"),
            Text("Latitude: ${locationStart?.latitude ?? 'N/A'}"),
          ],
        ),
      ),
    );
  }

  Future<void> startBackgroundService() async {
    final service = FlutterBackgroundService();
    bool isRunning = await service.isRunning();
    if (!isRunning) {
      service.startService();
    }
  }

  void toggleBackgroundService() async {
    final service = FlutterBackgroundService();
    bool isRunning = await service.isRunning();
    if (isRunning) {
      service.invoke("stopService");
      setState(() {
        text = "Start Service";
      });
    } else {
      service.invoke("startService");
      setState(() {
        text = "Stop Service";
      });
    }
  }

  @override
  void dispose() {
    // Stop the background service when the widget is disposed
    FlutterBackgroundService().invoke("stopService");
    super.dispose();
  }
}
