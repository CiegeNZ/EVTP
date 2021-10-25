import 'package:evtp/Tools/Location/location.dart';
import 'package:evtp/Tools/Maps/create_polylines.dart';
import 'package:evtp/UI/Components/Sliding%20Panel/SlidingPanel.dart';
import 'package:evtp/appState.dart';
import 'package:flutter/material.dart';

class ChargerDialogBox extends StatefulWidget {
  String title;
  String address;
  String latLng;
  List connections;
  String usage;
  String operator;

  ChargerDialogBox(BuildContext context, this.title, this.address, this.latLng,
      this.connections, this.usage, this.operator);

  @override
  _ChargerDialogBoxState createState() => _ChargerDialogBoxState();
}

class _ChargerDialogBoxState extends State<ChargerDialogBox> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 10),
                      blurRadius: 10),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          icon: Icon(Icons.close),
                          color: Colors.red,
                          iconSize: 32,
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "Charger Details",
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  widget.title + ", " + widget.address,
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 24,
                ),
                for (var a in widget.connections)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(a["ConnectionType"]["Title"] + " Quantity: "),
                      Text(a["Quantity"].toString() == "null"
                          ? "Unknown"
                          : a["Quantity"].toString()),
                    ],
                  ),
                SizedBox(
                  height: 11,
                ),
                Text(
                  widget.usage,
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 11,
                ),
                Text(
                  widget.operator,
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 11,
                ),
                ElevatedButton(
                    onPressed: () async {
                      createPolylines(await getLocationString(), widget.latLng);
                      setState(() {
                        AppState.isNavigating(true);
                        Navigator.of(context).pop();
                        slideController.open();
                      });
                    },
                    child: Text("Navigate to charger")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
