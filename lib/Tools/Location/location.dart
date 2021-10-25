import 'dart:async';
import 'package:evtp/Tools/Maps/ev_charge_service.dart';
import 'package:evtp/UI/Components/Map/ChargerMarker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

late StreamController<LocationData> locationStream;
late StreamSubscription<LocationData> locationChange;

bool running = false;
late Location location;
late LocationData _locationData;

//Create location object, broadcast streams and on change listeners
startLocation() async {
  if (!running) {
    try {
      location = new Location();
      locationStream = new StreamController<LocationData>();

      bool _serviceEnabled;
      PermissionStatus _permissionGranted;

      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      _locationData = await location.getLocation();

      locationChange =
          location.onLocationChanged.listen((LocationData currentLocation) {
        _locationData = currentLocation;
        locationStream.add(currentLocation);
      });
      running = true;
    } catch (e) {
      throw (e);
    }
  } else {
    locationChange.cancel();
    running = false;
    startLocation();
  }
}

//Closes the broadcast stream for sending locations
stopLocation() {
  locationStream.close();
}

//Last location is null if location has not run yet, so return default on error
getLastLocation() {
  try {
    return _locationData;
  } catch (e) {
    return new LatLng(-37.5, 175);
  }
}

//Return current location as a string
String getLocationString() {
  return (_locationData.latitude.toString() +
      "," +
      _locationData.longitude.toString());
}

//Return current location as LatLng
LatLng getLocationLatLng() {
  return (new LatLng(_locationData.latitude!, _locationData.longitude!));
}
