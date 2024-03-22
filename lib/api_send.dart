import 'package:gps_tracker/sharedData.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class SendApi {
  static Future<void> sendLocationToAPI(SharedData sharedData) async {
    try {
      const apiUrl =
          'http://irapid.top:8000/api/location'; // Replace with your API URL
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'busId': "test",
          'timestamp': sharedData.timeStamp.toString(),
          'latitude': sharedData.latitude.toString(),
          'longitude': sharedData.longitude.toString(),
        },
      );

      if (response.statusCode == 200) {
        print('Location sent to API successfully');
      } else {
        print(
            'Failed to send location to API. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error sending location to API: $error');
    }
  }
}
