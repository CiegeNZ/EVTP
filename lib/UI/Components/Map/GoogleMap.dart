import 'dart:async';
import 'package:evtp/Tools/Location/location.dart';
import 'package:evtp/Tools/Maps/create_polylines.dart';
import 'package:evtp/Tools/Maps/ev_charge_service.dart';
import 'package:evtp/UI/Components/Map/Camera.dart';
import 'package:evtp/UI/Components/Map/ChargerMarker.dart';
import 'package:evtp/appState.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps;
import 'package:location/location.dart';

class GoogleMap extends StatefulWidget {
  @override
  _GoogleMapState createState() => _GoogleMapState();

  bool isInitial = true;
  bool chargerLoad = false;
  late google_maps.LatLng _lastCameraPosition;
  late google_maps.LatLngBounds _bounds;

  Set<google_maps.Polyline> polylines = {};
  Set<google_maps.Marker> markers = {};
}

class _GoogleMapState extends State<GoogleMap> {
  late google_maps.GoogleMapController? mapController;
  late StreamSubscription<LocationData> locationSubscription;

  void _onMapCreated(google_maps.GoogleMapController controller) {
    mapController = controller;
    mapController!.setMapStyle(
        '[{"featureType":"landscape.natural","elementType":"geometry.fill","stylers":[{"visibility":"on"},{"color":"#e0efef"}]},{"featureType":"poi","elementType":"geometry.fill","stylers":[{"visibility":"on"},{"hue":"#1900ff"},{"color":"#c0e8e8"}]},{"featureType":"road","elementType":"geometry","stylers":[{"lightness":100},{"visibility":"simplified"}]},{"featureType":"road","elementType":"labels","stylers":[{"visibility":"off"}]},{"featureType":"transit.line","elementType":"geometry","stylers":[{"visibility":"on"},{"lightness":700}]},{"featureType":"water","elementType":"all","stylers":[{"color":"#7dcdcd"}]}]');
    locationSubscription = locationStream.stream.listen((l) {
      if (widget.isInitial == true) {
        widget.isInitial = false;
        controller.animateCamera(google_maps.CameraUpdate.newCameraPosition(
            google_maps.CameraPosition(
          target: new google_maps.LatLng(l.latitude!, l.longitude!),
          zoom: 16,
          tilt: 0,
        )));
      } else if (AppState.isNavigating() == true) {
        controller.animateCamera(google_maps.CameraUpdate.newCameraPosition(
            google_maps.CameraPosition(
                target: new google_maps.LatLng(l.latitude!, l.longitude!),
                bearing: l.heading!,
                zoom: 18,
                tilt: 30)));
      }
      if (widget.chargerLoad == false) {
        mapController!
            .getVisibleRegion()
            .then((value) => widget._bounds = value);
        addMarkersToMap(context, widget._bounds);
        widget.chargerLoad = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    markerStream.stream.listen((m) {
      setState(() {
        widget.markers = m;
      });
    });

    polylineStream.stream.listen((p) {
      setState(() {
        widget.polylines = p;
      });
    });

    AppState.stateStream.stream.asBroadcastStream().listen((event) {
      widget.isInitial = true;
      if (AppState.isNavigating() == false) {
        widget.polylines.clear();
      }
      setState(() {});
    });

    return Material(
      child: google_maps.GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: updateCamera(getLastLocation()),
        myLocationEnabled: true,
        polylines: widget.polylines,
        markers: widget.markers,
        onCameraMove: (v) {
          mapController!
              .getVisibleRegion()
              .then((value) => widget._bounds = value);
          // widget._lastCameraPosition =
          //     new google_maps.LatLng(v.target.latitude, v.target.longitude);
        },
        onCameraIdle: () async {
          if (AppState.isNavigating() == false) {
            addMarkersToMap(context, widget._bounds);
          }
        },
      ),
    );
  }
}
