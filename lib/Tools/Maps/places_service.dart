import "dart:convert";
import 'package:evtp/Tools/Location/location.dart';
import "package:flutter/material.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';
import "package:http/http.dart" as http;
import "package:uuid/uuid.dart";

List<Suggestion> _placeSuggestions = [];
const API_KEY = "AIzaSyDs17y0sm1xDuA_tFCswXJvESIrbcXA1KQ";

class Suggestion {
  late String name;
  late String description;
  late String placeID;

  Suggestion(this.name, _description, this.placeID) {
    description =
        (_description.toString() == "null" ? "No description" : _description);
    print("New Suggestion added:" + name + " (" + description + ")");
  }

  String getPlaceID() {
    return placeID;
  }
}

var uuid = new Uuid();
String _sessionToken = "0";
List<dynamic> _predictionList = [];
List<Suggestion> _placeSuggestionList = [];

//Called to check if current session is created
void initSuggestions() {
  print("Session: " + _sessionToken);
  if (_sessionToken == "0") {
    _sessionToken = uuid.v4();
  }
}

Future<List<Suggestion>> getSuggestion(String input) async {
  initSuggestions();
  try {
    String baseURL =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    String request = baseURL +
        "?input=" +
        input +
        "&key=" +
        API_KEY +
        "&sessiontoken=" +
        _sessionToken +
        "&location=" +
        await getLocationString() +
        "&radius=10000";
    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      print("Response: " + response.body);
      _predictionList = json.decode(response.body)["predictions"];
    } else {
      throw Exception("Failed to load predictions");
    }
  } catch (e) {
    print(e);
  }
  _placeSuggestionList.clear();
  for (var prediction in _predictionList) {
    _placeSuggestionList.add(new Suggestion(
        prediction['structured_formatting']['main_text'],
        prediction['description'],
        prediction['place_id']));
  }
  return _placeSuggestionList;
}

List<Suggestion> getPlaceSuggestions() {
  return _placeSuggestions;
}

void clearPlaceSuggestions() {
  _placeSuggestions.clear();
}

class Place {
  late String name;
  late String description;
  late LatLng location;
  //late int distance;

  Place(this.name, _description, this.location) {
    description =
        (_description.toString() == "null" ? "No description" : _description);

    print("New Suggestion added:" + name + " (" + description + ")");
  }

  String getLocation() {
    return "${location.latitude},${location.longitude}";
  }
}

late Map<String, dynamic> _placeDetailsResponse;
late Place _placeDetails;

Future<dynamic> getPlaceDetails(place) async {
  if (place == "") {
    throw ("No place entered");
  } else {
    try {
      String baseURL =
          "https://maps.googleapis.com/maps/api/place/details/json";
      String request = baseURL +
          "?place_id=" +
          place +
          "&fields=name,formatted_address,geometry" +
          "&key=" +
          API_KEY;
      var response = await http.get(Uri.parse(request));
      if (response.statusCode == 200) {
        print("Response: " + response.body);
        _placeDetailsResponse = json.decode(response.body);
      } else {
        throw Exception("Failed to load details");
      }
    } catch (e) {
      print(e);
    }

    print(_placeDetailsResponse["result"]["geometry"]);

    _placeDetails = new Place(
      _placeDetailsResponse["result"]["name"],
      _placeDetailsResponse["result"]["formatted_address"],
      new LatLng(_placeDetailsResponse["result"]["geometry"]["location"]["lat"],
          _placeDetailsResponse["result"]["geometry"]["location"]["lng"]),
    );

    return _placeDetails;
  }
}
