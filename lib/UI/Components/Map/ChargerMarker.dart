import 'dart:async';

import 'package:evtp/Tools/Maps/ev_charge_service.dart';
import 'package:evtp/UI/Components/Map/ChargerPopup.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

late StreamController<Set<Marker>> markerStream =
    new StreamController<Set<Marker>>.broadcast();

void addMarkersToMap(context, bounds) async {
  Set<Marker> markers = new Set();
  print("Getting Charging Stations ------------");
  var nearbyChargers = await getChargeStations(bounds);
  //Handle JSON return
  print(nearbyChargers.toString());
  try {
    for (var a in nearbyChargers) {
      // creating a new MARKER
      Marker marker = Marker(
        markerId: MarkerId(a["AddressInfo"]["ID"].toString()),
        position: new LatLng(
            a["AddressInfo"]["Latitude"], a["AddressInfo"]["Longitude"]),
        onTap: () {
          var usage;
          try {
            usage = a["UsageType"]["Title"].toString();
          } catch (e) {
            try {
              usage = a["GeneralComments"].toString();
            } catch (e) {
              usage = "Unknown";
            }
          }
          var operator;
          try {
            operator = a["OperatorInfo"]["Title"].toString();
          } catch (e) {
            operator = "Private/Unknown";
          }
          showDialog(
              barrierDismissible: true,
              context: context,
              builder: (BuildContext context) {
                return ChargerDialogBox(
                  context,
                  a["AddressInfo"]["Title"].toString(),
                  a["AddressInfo"]["AddressLine1"].toString(),
                  (a["AddressInfo"]["Latitude"].toString() +
                      "," +
                      a["AddressInfo"]["Longitude"].toString()),
                  a["Connections"],
                  usage,
                  operator,
                );
              });
        },
      );
      markers.add(marker);
    }
  } catch (e) {}
  markerStream.add(Set<Marker>.of(markers));
}
