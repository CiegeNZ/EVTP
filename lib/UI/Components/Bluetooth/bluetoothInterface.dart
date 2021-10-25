import 'dart:async';
import 'dart:convert';

import 'package:evtp/Tools/Bluetooth/bleHandler.dart';
import 'package:evtp/UI/Components/Bluetooth/scannedDeviceDialogBox.dart';
import 'package:evtp/UI/Components/Common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BLEInterface extends StatefulWidget {
  @override
  _BLEInterfaceState createState() => _BLEInterfaceState();
}

class _BLEInterfaceState extends State<BLEInterface> {
  List<ScanResult> scannedDevices = [];
  late BluetoothDevice selectedDevice;
  bool _obdSelected = false;
  bool _scanning = false;

  TextEditingController cmd_send = new TextEditingController();
  TextEditingController cmd_return = new TextEditingController();

  late StreamSubscription<List<int>> obdSubscription;

  String returnValue = "Return Value goes here\n";

  ScrollController sc = new ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EVTP App',
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          title: Text("EVTP App - BT Testing"),
          leading: closeToMain(context),
        ),
        body: ListView(
          children: <Widget>[
            Center(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(12, 20, 12, 20),
                  child: TextButton(
                    onPressed: () async {
                      setState(() {
                        _scanning = true;
                      });
                      scannedDevices = await startDiscovery();
                      print(scannedDevices.length);
                      setState(() {
                        _scanning = false;
                      });
                      await showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                                builder: (context, setstate) {
                              return scannedDevicesDialogBox(
                                  context, scannedDevices);
                            });
                          }).then((value) => print(value));
                      setState(() {
                        try {
                          selectedDevice = getOBDDevice();
                          _obdSelected = true;
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
                    child: _scanning == false
                        ? Text(
                            "Scan for Devices",
                            style: TextStyle(
                              background: Paint()
                                ..color = Colors.green
                                ..strokeWidth = 17
                                ..strokeCap = StrokeCap.round
                                ..strokeJoin = StrokeJoin.round
                                ..style = PaintingStyle.stroke,
                              color: Colors.white,
                            ),
                          )
                        : CircularProgressIndicator(
                            color: Colors.green,
                          ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                      child: Center(
                        child: Text(_obdSelected == true
                            ? selectedDevice.name.toString()
                            : "No Device Selected"),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        disconnectDevice();
                        setState(() {
                          _obdSelected = false;
                          obdSubscription.cancel();
                        });
                      },
                      child: Text("Disconnect"),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                startMonitorCommand();
              },
              child: Text("Monitor"),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              scrollController: sc,
              controller: cmd_return,
              maxLines: 10,
            )
          ],
        ),
      ),
    );
  }
}
