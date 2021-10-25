import 'package:evtp/Tools/Bluetooth/bleHandler.dart';
import 'package:evtp/UI/Components/Sliding Panel/routeSearch.dart';
import 'package:evtp/UI/Components/Sliding Panel/tripStats.dart';
import 'package:evtp/UI/Components/Sliding Panel/initOBD.dart';

import 'package:evtp/appState.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:evtp/Tools/Location/location.dart';
import 'package:evtp/Tools/Maps/create_polylines.dart';
import 'package:evtp/Tools/Maps/places_service.dart' as places;

final slideController = new PanelController();

class SlideUpPanel extends StatefulWidget {
  @override
  _SlideUpPanelState createState() => _SlideUpPanelState();
}

class _SlideUpPanelState extends State<SlideUpPanel> {
  @override
  Widget build(BuildContext context) {
    AppState.stateStream.stream.asBroadcastStream().listen((event) {
      setState(() {});
    });

    if (AppState.isNavigating() == false) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: SlidingUpPanel(
          maxHeight: (MediaQuery.of(context).size.height * 0.8),
          defaultPanelState: PanelState.CLOSED,
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(50), bottom: Radius.zero),
          controller: slideController,
          collapsed: Container(
            decoration: BoxDecoration(),
          ),
          panel: Center(
            child: Column(
              children: [
                Icon(Icons.drag_handle_rounded),
                RouteSearch(routeCallback: (String start, String end) {
                  setState(() async {
                    AppState.isNavigating(true);
                    slideController.close();
                    FocusScope.of(context).unfocus();
                    print("Navigation request: " + start + " to " + end);
                    late places.Place startPlace;
                    if (start == "Current Location") {
                      startPlace = new places.Place("Current Location",
                          "Your Current Location", await getLocationLatLng());
                    } else {
                      startPlace = await places.getPlaceDetails(start);
                    }
                    places.Place endPlace = await places.getPlaceDetails(end);
                    //perform search and add to map
                    createPolylines(
                        startPlace.getLocation(), endPlace.getLocation());
                  });
                })
              ],
            ),
          ),
        ),
      );
    } else if (AppState.isNavigating() == true &&
        AppState.isOBDConnected() == true) {
      try {
        slideController.animatePanelToSnapPoint();
      } catch (e) {}
      return Align(
        alignment: Alignment.bottomCenter,
        child: SlidingUpPanel(
          maxHeight: (MediaQuery.of(context).size.height * 0.41),
          snapPoint: 0.675,
          //Shift center of map up?
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(50), bottom: Radius.zero),
          controller: slideController,
          collapsed: Container(
            decoration: BoxDecoration(),
          ),
          panel: Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.drag_handle_rounded),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                                primary: Colors.red.shade300),
                            onPressed: () {
                              slideController.open();
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: Colors.red.shade300),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                TripStats(
                  voidCallback: () {
                    setState(() {
                      AppState.isNavigating(false);
                      slideController.close();
                    });
                  },
                )
              ],
            ),
          ),
        ),
      );
    } else if (AppState.isNavigating() == true &&
        AppState.isOBDConnected() == false) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: SlidingUpPanel(
          maxHeight: (MediaQuery.of(context).size.height * 0.4),
          defaultPanelState: PanelState.OPEN,
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(50), bottom: Radius.zero),
          controller: slideController,
          collapsed: Container(
            decoration: BoxDecoration(),
          ),
          panel: Center(
            child: Column(
              children: [Icon(Icons.drag_handle_rounded), initOBD()],
            ),
          ),
        ),
      );
    } else {
      return Align(
        alignment: Alignment.bottomCenter,
        child: SlidingUpPanel(
          maxHeight: (MediaQuery.of(context).size.height * 0.4),
          defaultPanelState: PanelState.OPEN,
          //Shift center of map up?
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(50), bottom: Radius.zero),
          controller: slideController,
          collapsed: Container(
            decoration: BoxDecoration(),
          ),
          panel: Center(
            child: Text("Application Error"),
          ),
        ),
      );
    }
  }
}
