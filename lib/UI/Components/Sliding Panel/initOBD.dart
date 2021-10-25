import 'dart:async';
import 'dart:convert';

import 'package:evtp/Tools/Bluetooth/bleHandler.dart';
import 'package:evtp/UI/Components/Bluetooth/scannedDeviceDialogBox.dart';
import 'package:evtp/UI/Components/Sliding%20Panel/SlidingPanel.dart';
import 'package:evtp/appState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class initOBD extends StatefulWidget {
  @override
  _initOBDState createState() => _initOBDState();
}

class _initOBDState extends State<initOBD> {
  List<ScanResult> scannedDevices = [];
  late BluetoothDevice selectedDevice;

  late StreamSubscription<List<int>> obdSubscription;

  TextEditingController cmd_send = new TextEditingController();
  TextEditingController cmd_return = new TextEditingController();

  late StreamSubscription<dynamic> stateListener;

  String returnValue = "Return Value goes here\n";

  ScrollController sc = new ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    stateListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    stateListener =
        AppState.stateStream.stream.asBroadcastStream().listen((event) async {
      setState(() {});
    });

    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(12, 20, 12, 20),
                child: TextButton(
                  onPressed: () async {
                    AppState.isScanning(true);
                    try {
                      scannedDevices = await startDiscovery();
                    } catch (e) {}
                    print(scannedDevices.length);
                    AppState.isScanning(false);
                    await showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(builder: (context, setstate) {
                            return scannedDevicesDialogBox(
                                context, scannedDevices);
                          });
                        }).then((value) => print(value));
                    setState(() {
                      try {
                        selectedDevice = getOBDDevice();
                        AppState.isOBDConnected(true);
                        obdSubscription = obdStream.stream.listen((r) {
                          setState(() {
                            cmd_return.text += ascii.decode(r);
                          });
                        });
                      } catch (e) {
                        print(e);
                      }
                    });
                  },
                  child: AppState.isScanning() == false
                      ? Text(
                          "Scan for Devices",
                          style: TextStyle(
                            background: Paint()
                              ..color = Colors.teal
                              ..strokeWidth = 24
                              ..strokeCap = StrokeCap.round
                              ..strokeJoin = StrokeJoin.round
                              ..style = PaintingStyle.stroke,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        )
                      : CircularProgressIndicator(
                          color: Colors.teal,
                        ),
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 8, 0, 16),
                    child: Center(
                      child: Text(AppState.isOBDConnected() == true
                          ? selectedDevice.name.toString()
                          : "No Device Selected"),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: AppState.isOBDConnected() == true
                            ? Colors.teal
                            : Colors.grey.shade300),
                    onPressed: () {
                      if (AppState.isOBDConnected() == true) {
                        disconnectDevice();
                        setState(() {
                          AppState.isOBDConnected(false);
                          obdSubscription.cancel();
                        });
                      } else {
                        //disabled
                      }
                    },
                    child: Text("Disconnect"),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              slideController.close();
              AppState.isNavigating(false);
            },
            child: Text("Cancel Navigation"),
            style: ElevatedButton.styleFrom(primary: Colors.red.shade300),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     startMonitorCommand();
          //   },
          //   child: Text("Monitor"),
          // ),
          // SizedBox(
          //   height: 15,
          // ),
          // TextFormField(
          //   scrollController: sc,
          //   controller: cmd_return,
          //   maxLines: 10,
          // )
        ],
      ),
    );
  }
}
