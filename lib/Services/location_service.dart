import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Models/location_model.dart';

class LocationServices {
  Future<LocationDataModel> getLocations() async {
    Map<String, dynamic> resBody;

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST',
        Uri.parse('http://fifaar.com/public/api/show-all-storage-loaction'));
    request.body = json.encode({
      "security_error": "tec71",
      "latitude": "23.753229445333893",
      "longtude": "90.41661109775305"
    });
    request.headers.addAll(headers);

    var response = await request.send();
    var res = await http.Response.fromStream(response);
    resBody = jsonDecode(res.body) as Map<String, dynamic>;

    if (res.statusCode == 200) {
      print("Loaded");
      print(resBody);
      return LocationDataModel.fromJson(resBody);
    } else {
      return LocationDataModel.fromJson(resBody);
    }
  }
}
