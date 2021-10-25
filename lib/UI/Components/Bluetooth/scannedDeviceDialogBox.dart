import 'package:evtp/Tools/Bluetooth/bleHandler.dart';
import 'package:evtp/appState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

scannedDevicesDialogBox(context, List<ScanResult> scannedDevices) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    elevation: 0,
    backgroundColor: Colors.transparent,
    child: Stack(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            background: Paint()
                              ..color = Colors.red.shade300
                              ..strokeWidth = 17
                              ..strokeCap = StrokeCap.round
                              ..strokeJoin = StrokeJoin.round
                              ..style = PaintingStyle.stroke,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Select Device",
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              for (var i in returnScanned(context, scannedDevices)) i,
            ],
          ),
        )
      ],
    ),
  );
}

returnScanned(context, scannedDevices) {
  List<Widget> scannedToString = [];
  for (ScanResult s in scannedDevices) {
    scannedToString.add(TextButton(
      onPressed: () {
        setOBDDevice(s);
        Navigator.of(context).pop();
      },
      child: Text(s.device.name.toString() == ""
          ? s.device.id.toString()
          : s.device.name.toString()),
    ));
  }
  return scannedToString;
}
