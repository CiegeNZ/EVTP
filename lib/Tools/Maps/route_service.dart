import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

late List<dynamic> _directionRequest;
const API_KEY = "AIzaSyDs17y0sm1xDuA_tFCswXJvESIrbcXA1KQ";

Future<String> getDirections(String start, String end) async {
  try {
    String baseURL = "https://maps.googleapis.com/maps/api/directions/json";
    String request = baseURL +
        "?origin=" +
        start.toString() +
        "&destination=" +
        end.toString() +
        //waypoints
        "&key=$API_KEY";
    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      print("Response: " + response.body);
      _directionRequest = json.decode(response.body)["routes"];
    } else {
      throw Exception("Failed to load directions");
    }
  } catch (e) {
    print(e);
  }

  return _directionRequest.toString();
}
