import 'dart:async';
import 'dart:ui';
import 'package:background_location/background_location.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:gps_tracker/sharedData.dart';
import 'package:gps_tracker/sharedDataStore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_send.dart';
import 'location_controller.dart';

class BackgroundService {
  StreamController<SharedData?> locationStreamController =
      StreamController<SharedData?>.broadcast();
  final int _repeatTimer = 5;
  Location? _locationNow;
  final SharedData _sharedDataInstance = SharedData();
  var dataStore = SingletonDataStore.instance;

  BackgroundService();

  // Function to initialize the background service
  Future<void> initializeService() async {
    final service = FlutterBackgroundService();
    try {
      LocationService().initBackgroundLocation();
      await service.configure(
        iosConfiguration: IosConfiguration(
          autoStart: true,
          onForeground: _onStart,
        ),
        androidConfiguration: AndroidConfiguration(
          onStart: _onStart,
          isForegroundMode: true,
        ),
      );
    } catch (e) {
      print("Error configuring background service: $e");
    }
  }

  // Top-level function to delegate to the instance
  static void _onStart(ServiceInstance service) {
    BackgroundService()._onStartInternal(service);
  }

  // Internal onStart method with access to the instance
  void _onStartInternal(ServiceInstance service) async {
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

    Timer.periodic(Duration(seconds: _repeatTimer), (timer) async {
      try {
        _locationNow = await LocationService().getLocation();

        // print("Repeating print every $_repeatTimer seconds");
        // print(
        //     "Location Now = Latitude ${_locationNow?.latitude}, longitude ${_locationNow?.longitude}, at ${_locationNow?.time}");

        updateLocation(_locationNow?.latitude, _locationNow?.longitude, _locationNow?.time?.round());
        locationStreamController.add(_sharedDataInstance);
        await saveData(_sharedDataInstance);
        await SendApi.sendLocationToAPI(_sharedDataInstance);

        // print("Bus Id = ${_sharedDataInstance.busID}");
        // print("Latitude = ${_sharedDataInstance.latitude}");
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        print(prefs.getInt('lastUpdateTimestamp') ?? 0);
        print(_sharedDataInstance.lastUpdateTimestamp);
      } catch (e) {
        print("Error getting location: $e");
      }
    });
    service.invoke('update');
  }

  // Function to update the shared data instance
  void updateBusID(String newBusId) {
    _sharedDataInstance.updateBusId(newBusId);
  }

  void updateLocation(double? latitude, double? longitude, int? lastUpdateTimestamp) {
    _sharedDataInstance.updateLocation(latitude, longitude, lastUpdateTimestamp);
  }

  String? getbusID() {
    return _sharedDataInstance.busID;
  }

  Future<void> saveData(SharedData sharedData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('latitude', sharedData.latitude!);
    await prefs.setDouble('longitude', sharedData.longitude!);
    await prefs.setInt('timeStamp', sharedData.timeStamp!);
    await prefs.setInt('lastUpdateTimestamp', sharedData.lastUpdateTimestamp!);
  }

}
