import 'dart:convert';

import 'package:air_quality_app/data/air_quality.dart';
import 'package:air_quality_app/data/api_key.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

Future<AirQuality?> fetchData() async {
  try {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition();
    var url = Uri.parse(
      'https://api.waqi.info/feed/geo:${position.latitude};${position.longitude}/?token=$apiKey',
    );
    var response = await http.get(url);
    if (response.statusCode == 200) {
      AirQuality airQuality = AirQuality.fromJson(jsonDecode(response.body));
      if (airQuality.aqi >= 0 && airQuality.aqi <= 50) {
        airQuality.emojiRef = "assets/1.png";
        airQuality.message =
            "Air quality is considered satisfactory, and air pollution poses little or no risk.";
      } else if (airQuality.aqi > 50 && airQuality.aqi <= 100) {
        airQuality.emojiRef = "assets/2.png";
        airQuality.message =
            "Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people who are unusually sensitive to air pollution.";
      } else if (airQuality.aqi > 100 && airQuality.aqi <= 150) {
        airQuality.emojiRef = "assets/3.png";
        airQuality.message =
            "Members of sensitive groups may experience health effects. The general public is not likely to be affected.";
      } else if (airQuality.aqi > 150 && airQuality.aqi <= 200) {
        airQuality.emojiRef = "assets/4.png";
        airQuality.message =
            "Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects.";
      } else if (airQuality.aqi > 200 && airQuality.aqi <= 250) {
        airQuality.emojiRef = "assets/5.png";
        airQuality.message =
            "Health alert: everyone may experience more serious health effects. The entire population is more likely to be affected.";
      } else if (airQuality.aqi > 250 && airQuality.aqi <= 300) {
        airQuality.emojiRef = "assets/6.png";
        airQuality.message =
            "Health alert: everyone may experience more serious health effects. The entire population is more likely to be affected.";
      }
      print(airQuality);
      return airQuality;
    }
    return null;
  } catch (e) {
    log(e.toString());
    rethrow;
  }
}
