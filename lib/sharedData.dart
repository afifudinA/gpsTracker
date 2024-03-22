// shareData.dart

import 'package:flutter/foundation.dart';

class SharedData with ChangeNotifier {
  String? busID;
  double? latitude;
  double? longitude;
  int? timeStamp;
  int? lastUpdateTimestamp;

  // Constructor
  SharedData({
    this.busID,
    this.latitude,
    this.longitude,
    this.timeStamp,
    this.lastUpdateTimestamp
  });

  // Factory method to create an instance from a map
  factory SharedData.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      throw ArgumentError("Map cannot be null");
    }

    return SharedData(
      busID: map['busID'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      timeStamp: map['timeStamp'],
      lastUpdateTimestamp: map['lastUpdateTimestamp'],
    );
  }

  // Method to convert the instance to a map
  Map<String, dynamic> toMap() {
    return {
      'busID': busID,
      'latitude': latitude,
      'longitude': longitude,
      'timeStamp': timeStamp,
      'lastUpdateTimestamp': lastUpdateTimestamp,
    };
  }

  void updateBusId(String newBusId) {
    busID = newBusId;
    notifyListeners(); // Notify listeners about the change
  }

  void updateLocation(double? newlatitude, double? newlongitude, int? newLastUpdateTimestamp) {
    latitude = newlatitude;
    longitude = newlongitude;
    timeStamp = DateTime.now().millisecondsSinceEpoch;
    lastUpdateTimestamp = newLastUpdateTimestamp;
    notifyListeners(); // Notify listeners about the change
  }
}
