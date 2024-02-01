import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class sendApi {
  static Future<void> sendLocationToAPI(Position position) async {
    try {
      final apiUrl =
          'https://script.google.com/macros/s/AKfycbxm80rH_2lv_I5wz-ExR580K9kFtef44308FSkRmRWjY-8aE1P2ZekhZrfs4buCwSXH7Q/exec'; // Replace with your API endpoint
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'latitude': position.latitude.toString(),
          'longitude': position.longitude.toString(),
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
