import 'dart:async';

import 'package:amplify_flutter/amplify.dart';
import 'package:evtp/UI/Components/Common/common.dart';
import 'package:evtp/main.dart';
import 'package:evtp/models/ModelProvider.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:sensors_plus/sensors_plus.dart';

import 'package:evtp/UI/Components/Sidebar/NavigationDrawer.dart';

// Future<void> saveData() async {
//   Users newUser = Users(name: "Steve Test");
//   await Amplify.DataStore.save(newUser);
// }

class DataCollection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EVTP App',
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          title: Text("EVTP App - Data Collection"),
        ),
        drawer: NavigationDrawer(),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Data Collection Page",
                style: TextStyle(fontSize: 28),
              ),
              DataCollectionForm(),
            ],
          ),
        ),
      ),
    );
  }
}

String timeNow() {
  DateTime now = DateTime.now();
  String time = now.hour.toString() +
      ':' +
      now.minute.toString() +
      '.' +
      now.second.toString();

  return time;
}

class DataCollectionForm extends StatelessWidget {
  final tripName = TextEditingController();
  final tripStart = TextEditingController();
  final tripTime = TextEditingController(text: timeNow());

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        margin: const EdgeInsets.fromLTRB(0.0, 24.0, 0.0, 8.0),
        color: Colors.green,
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.75,
            margin: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
            color: Colors.white,
            child: Column(
              children: [
                Card(
                  child: Align(
                    alignment: Alignment.center,
                    child: TextFormField(
                      controller: tripName,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                      },
                      decoration: InputDecoration(
                        labelText: 'Trip Name',
                        prefixIcon: Icon(Icons.trip_origin),
                        suffix: IconButton(
                            icon: Icon(Icons.cancel),
                            onPressed: () {
                              tripName.clear();
                              FocusScope.of(context).unfocus();
                            }),
                      ),
                    ),
                  ),
                ),
                Card(
                  child: Align(
                    alignment: Alignment.center,
                    child: TextFormField(
                      controller: tripStart,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                      },
                      decoration: InputDecoration(
                        labelText: 'Start Location',
                        prefixIcon: Icon(Icons.map),
                        suffix: IconButton(
                            icon: Icon(Icons.cancel),
                            onPressed: () {
                              tripStart.clear();
                              FocusScope.of(context).unfocus();
                            }),
                      ),
                    ),
                  ),
                ),
                Card(
                  child: Align(
                    alignment: Alignment.center,
                    child: TextFormField(
                      controller: tripTime,
                      enabled: false,
                      decoration: InputDecoration(
                        enabled: false,
                        labelText: 'Start Time',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        prefixIcon: Icon(Icons.access_time),
                      ),
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => SensorData(
                                name: tripName.text,
                                start: tripStart.text,
                                time: tripTime.text,
                              )));
                      // saveData();
                      //Start Logging
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Start Trip",
                          style: TextStyle(fontSize: 26),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.check),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SensorData extends StatefulWidget {
  final String name;
  final String start;
  final String time;
  const SensorData(
      {Key? key, required this.name, required this.start, required this.time})
      : super(key: key);

  @override
  _SensorDataState createState() => _SensorDataState();
}

class _SensorDataState extends State<SensorData> {
  AccelerometerEvent? accelerometerEvent;
  Timer? _timer;
  Timer? _timer2;

  Location _location = new Location();
  late LocationData _currentPosition;

  var packet = [];

  void startTimer() {
    const duration = const Duration(milliseconds: 500);
    _timer = new Timer.periodic(
      duration,
      (Timer timer) {
        print("tick");
        updateAccel();
        getLoc();
        addToPacket();
      },
    );
  }

  void startTimer2() {
    const duration = const Duration(seconds: 60);
    _timer2 = new Timer.periodic(
      duration,
      (Timer timer) {
        print("sending packet");
        print(packet.toString());
        //datastore.sendPacket(packet);
      },
    );
  }

  void getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await _location.getLocation();

    _location.onLocationChanged.listen((LocationData currentLocation) {
      print("${currentLocation.longitude} : ${currentLocation.longitude}");
      setState(() {
        _currentPosition = currentLocation;
      });
    });
  }

  void updateAccel() {
    setState(() {
      accelerometerEvents.listen((AccelerometerEvent event) {
        accelerometerEvent = event;
      });
    });
  }

  //Return accel in g-force
  String getAccel(String dir) {
    if (accelerometerEvent != null) {
      if (dir == "x") {
        return ((accelerometerEvent!.x) / 9.81).toStringAsFixed(4);
      } else if (dir == "y") {
        return ((accelerometerEvent!.y) / 9.81).toStringAsFixed(4);
      } else if (dir == "z") {
        return ((accelerometerEvent!.z) / 9.81).toStringAsFixed(4);
      }
    }
    return ("Accelerometer not initilized");
  }

  //determine orientation
  String calcOrientation() {
    if (accelerometerEvent != null) {
      if (accelerometerEvent!.x >= 8) {
        return ("Landscape (left)");
      } else if (accelerometerEvent!.x <= -8) {
        return ("Landscape (right)");
      } else if (accelerometerEvent!.y >= 8) {
        return ("Upright");
      } else if (accelerometerEvent!.y <= -8) {
        return ("Upside down");
      } else if (accelerometerEvent!.z >= 8) {
        return ("Screen up");
      } else if (accelerometerEvent!.z <= -8) {
        return ("Screen down (haha cant see me)");
      } else {
        return ("Between orientations");
        //Calculate 45% angles?
      }
    }
    return ("Accelerometer not initilized");
  }

  //Need to initilised 0 values
  // If g exceeds 1.1 etc turn in that direction?
  // X = phone side
  // Y = phone top/bottom
  // Z = phone screen

  //Collect data and package to database
  // 1 min intervals = 120 lines

  String timeNow() {
    DateTime now = DateTime.now();
    String time = now.hour.toString() +
        ':' +
        now.minute.toString() +
        '.' +
        now.second.toString() +
        '(' +
        now.millisecond.toString() +
        ')';

    return time;
  }

  void addToPacket() {
    packet.add(timeNow() +
        "," +
        getAccel("x") +
        "," +
        getAccel("y") +
        "," +
        getAccel("z") +
        ", GPS, Elevation, OBD etc... \n");
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer2?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_timer == null) {
      startTimer();
      startTimer2();
    }
    return MaterialApp(
      title: 'EVTP App',
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          title: Text("EVTP App - Sensor Collection"),
          leading: closeToMain(context),
        ),
        body: Container(
          child: Stack(
            children: <Widget>[
              Center(
                child: ListView(
                  children: <Widget>[
                    Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                            child: Text("Trip Name: " + widget.name),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                            child: Text("Start Location: " + widget.start),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                            child: Text("Start Time: " + widget.time),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                            child: Text("Time Now: " + timeNow()),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                            child: Text("Accel X: " + getAccel("x") + " g"),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                            child: Text("Accel Y: " + getAccel("y") + " g"),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                            child: Text("Accel Z: " + getAccel("z") + " g"),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                            child: Text(
                                "Device Orientation: " + calcOrientation()),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                            child: Text("Device Location: " +
                                _currentPosition.latitude.toString() +
                                " " +
                                _currentPosition.longitude.toString()),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                            child: Text(
                              "Device Elevation: " +
                                  _currentPosition.altitude.toString(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
