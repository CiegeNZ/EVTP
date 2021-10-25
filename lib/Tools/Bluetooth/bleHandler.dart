import 'dart:async';
import 'dart:convert';
import 'package:flutter_blue/flutter_blue.dart';

StreamController<List<int>> obdStream = new StreamController<List<int>>();
late StreamSubscription<List<ScanResult>> scanSubcription;
late StreamSubscription<List<int>> obdSubcription;
late BluetoothDevice obd;
late BluetoothCharacteristic obdATChar;

bool scanning = false;
bool monitoring = false;

final FlutterBlue flutterBlue = FlutterBlue.instance;

//Check if is ready
Future<bool> initCheck() async {
  if (await flutterBlue.isAvailable) {
    if (await flutterBlue.isOn) {
      return true;
    }
  }
  return false;
}

void reScan() {
  flutterBlue.stopScan().then((value) {
    scanSubcription.cancel();
    startDiscovery();
  });
}

//Scan for devices
Future<List<ScanResult>> startDiscovery() async {
  // Stop previous scans
  await flutterBlue.stopScan();
  List<ScanResult> scannedDevice = [];
  if (!scanning) {
    if (!(await initCheck())) {
      return scannedDevice;
    }
    // Start scanning
    scanning = true;
    await flutterBlue.startScan(timeout: Duration(seconds: 3));

    // Listen to scan results
    scanSubcription = flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult r in results) {
        print('${r.device.name} found! rssi: ${r.rssi}');
        scannedDevice.add(r);
      }
    });
// Stop scanning
    await flutterBlue.stopScan();
    scanning = false;
    return scannedDevice;
  } else {
    print("Error Occured");
    return scannedDevice;
  }
}

void setOBDDevice(ScanResult d) {
  obd = d.device;
  connectDevice(obd);
}

BluetoothDevice getOBDDevice() {
  return obd;
}

void connectDevice(BluetoothDevice device) async {
  //Connect device
  await device.connect();
  //Scan services
  List<BluetoothService> services = await device.discoverServices();
  services.forEach((service) {
    // check for correct service
    for (BluetoothCharacteristic characteristic in service.characteristics) {
      if (characteristic.uuid.toString() ==
          "0000ffe1-0000-1000-8000-00805f9b34fb") {
        obdATChar = characteristic;
        print("Matched Char");
        obdATChar.setNotifyValue(true);
        obdSubcription = obdATChar.value.listen((r) {
          if (r.contains("STOP")) {
            monitoring = false;
          } else if (r.contains("ATMA")) {
            monitoring = true;
          } else if (r.contains("55B")) {
            handleSOCResponse(r.toString().substring(3, r.length));
          } else if (r.contains("5C5")) {
            //ODO

            print("ODO reading:" + r.toString());
          } else if (r.contains("354")) {
            //Speed
            handleSpeedResponse(r.toString().substring(3, r.length));
          } else if (r.contains("1DC")) {
            //RemainingKW
            handlekWResponse(r.toString());
          }

          // print("OBD Response: " + ascii.decode(r));

          obdStream.add(r);
          //Clean data
          //add to data_collection packet to send to data store
        });
        initCommands();
        Timer(Duration(milliseconds: 3900), () {
          startMonitorCommand();
        });
      }
    }
  });
}

void disconnectDevice() {
  obd.disconnect();
}

void initCommands() {
  Timer(Duration(milliseconds: 300), () {
    obdATChar.write(utf8.encode("ATZ" + "\r"));
  });
  Timer(Duration(milliseconds: 600), () {
    obdATChar.write(utf8.encode("ATE0" + "\r"));
  });
  Timer(Duration(milliseconds: 900), () {
    obdATChar.write(utf8.encode("ATH1" + "\r"));
  });
  Timer(Duration(milliseconds: 1200), () {
    obdATChar.write(utf8.encode("ATL1" + "\r"));
  });
  Timer(Duration(milliseconds: 1500), () {
    obdATChar.write(utf8.encode("ATS1" + "\r"));
  });
  Timer(Duration(milliseconds: 2100), () {
    obdATChar.write(utf8.encode("ATAL" + "\r"));
  });
  Timer(Duration(milliseconds: 2400), () {
    obdATChar.write(utf8.encode("ATCM7FF" + "\r"));
  });
  Timer(Duration(milliseconds: 2700), () {
    obdATChar.write(utf8.encode("ATCF5C5" + "\r")); //ODO
  });
  Timer(Duration(milliseconds: 3000), () {
    obdATChar.write(utf8.encode("ATCF354" + "\r")); //Speed
  });
  Timer(Duration(milliseconds: 3300), () {
    obdATChar.write(utf8.encode("ATCF55B" + "\r")); //SoC
  });
  Timer(Duration(milliseconds: 3600), () {
    obdATChar.write(utf8.encode("ATCF1DC" + "\r")); //RemainingKW
  });
}

void startMonitorCommand() {
  //send the commands and listen
  if (monitoring == false) {
    obdATChar.write(utf8.encode("ATMA" + "\r")); //Start
    monitoring = true;
  } else {
    obdATChar.write(utf8.encode("\r")); //End
    monitoring = false;
  }
}

void handleSOCResponse(String r) {
  int soc = int.parse(r.substring(1, 5), radix: 16);
  double percent = soc * (100 / 65535);
  print("SOC updated: " + percent.toString());
}

void handleODOResponse(String r) {
  //Find out
  int odo = int.parse(r.substring(3, 9).toString(), radix: 16);
  print("ODO updated: " + odo.toString());
}

void handleSpeedResponse(String r) {
  int speed = int.parse(r.substring(1, 5).toString(), radix: 16);
  double conv = speed / 100;
  print("Speed updated: " + conv.toString());
}

void handlekWResponse(String r) {
  int kw = int.parse(r.substring(1, 2).toString(), radix: 16);
  print("kW updated: " + kw.toString());
}
