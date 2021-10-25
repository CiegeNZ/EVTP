import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps;

// Object for PolylinePoints
late PolylinePoints polylinePoints;
const API_KEY = "AIzaSyDs17y0sm1xDuA_tFCswXJvESIrbcXA1KQ";
late StreamController<Set<google_maps.Polyline>> polylineStream =
    new StreamController<Set<google_maps.Polyline>>.broadcast();

// List of coordinates to join
List<google_maps.LatLng> polylineCoordinates = [];

// Map storing polylines created by connecting two points
Map<google_maps.PolylineId, google_maps.Polyline> polylines = {};

// Create the polylines for showing the route between two places
void createPolylines(String start, String destination) async {
  polylineCoordinates.clear();
  // Initializing PolylinePoints
  polylinePoints = PolylinePoints();

  // Generating the list of coordinates to be used for
  // drawing the polylines
  PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
    API_KEY, // Google Maps API Key
    PointLatLng(
        double.parse(start.split(',')[0]), double.parse(start.split(',')[1])),
    PointLatLng(double.parse(destination.split(',')[0]),
        double.parse(destination.split(',')[1])),
  );

  // Adding the coordinates to the list
  if (result.points.isNotEmpty) {
    result.points.forEach((PointLatLng point) {
      polylineCoordinates
          .add(google_maps.LatLng(point.latitude, point.longitude));
    });
  }

  // Initializing Polyline
  google_maps.PolylineId id = google_maps.PolylineId('poly');
  google_maps.Polyline polyline = google_maps.Polyline(
    polylineId: id,
    color: Colors.teal.shade400,
    points: polylineCoordinates,
    width: 3,
  );

  // Adding the polyline to the map
  polylines[id] = polyline;

  polylineStream.add(Set<google_maps.Polyline>.of(polylines.values));
  print("Directions and polyline -- DONE");
}
