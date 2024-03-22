import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:gps_tracker/sharedDataStore.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  double? latitude;
  double? longitude;
  int? timeStamp;
  String? busID;

  @override
  void initState() {
    super.initState();
    startBackgroundService();
    Timer.periodic(const Duration(seconds: 5), (timer) async {
      await loadData();
      setState(() {
        latitude = latitude;
        longitude = longitude;
        timeStamp = DateTime.now().millisecondsSinceEpoch;
        busID = busID;
      });
    });
  }

  Future<void> loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    latitude = prefs.getDouble('latitude') ?? 0.0;
    longitude = prefs.getDouble('longitude') ?? 0.0;
    timeStamp = prefs.getInt('timeStamp') ?? 0;
    busID = prefs.getString('busId') ?? "N/A";
    print(prefs.getInt('lastUpdateTimestamp') ?? 0);
    // print(timeStamp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GPS Tracker"),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
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
                              loadData();
                            },
                          ),
                        ),
                      );

                      // Check if result is not null and handle it if needed
                      if (result != null) {
                        print("Result from SettingsPage: $result");
                      }
                    },
                    child: const Text("Settings"),
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
            const SizedBox(height: 20),
            Text("Bus ID: ${busID ?? 'N/A'}"),
            Text("TimeStamp: ${timeStamp ?? 'N/A'}"),
            Text("Latitude: ${latitude ?? 'N/A'}"),
            Text("Longitude: ${longitude ?? 'N/A'}"),
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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getInt('lastUpdateTimestamp') ?? 0);
    // final service = FlutterBackgroundService();
    // bool isRunning = await service.isRunning();
    // if (isRunning) {
    //   service.invoke("stopService");
    //   setState(() {
    //     text = "Start Service";
    //   });
    // } else {
    //   service.invoke("startService");
    //   setState(() {
    //     text = "Stop Service";
    //   });
    // }
  }

  @override
  void dispose() {
    // Stop the background service when the widget is disposed
    FlutterBackgroundService().invoke("stopService");
    super.dispose();
  }
}
