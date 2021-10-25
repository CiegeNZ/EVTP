import 'dart:async';

class AppState {
  static StreamController stateStream = new StreamController<bool>.broadcast();

  static isNavigating([bool? value]) {
    if (value == null) {
      return _navigating;
    } else {
      _navigating = value;
      stateStream.add(true);
      return _navigating;
    }
  }

  static isScanning([bool? value]) {
    if (value == null) {
      return _scanning;
    } else {
      _scanning = value;
      stateStream.add(true);
      return _scanning;
    }
  }

  static needRescan([bool? value]) {
    if (value == null) {
      return _rescan;
    } else {
      _rescan = value;
      stateStream.add(true);
      return _rescan;
    }
  }

  static isOBDConnected([bool? value]) {
    if (value == null) {
      return _OBDConnected;
    } else {
      _OBDConnected = value;
      stateStream.add(true);
      return _OBDConnected;
    }
  }

  static bool _navigating = true;
  static bool _centered = false;
  static bool _scanning = false;
  static bool _rescan = false;
  static bool isLoggedIn = false;
  static bool isDataLogging = false;
  static bool _OBDConnected = false;

  void dispose() {
    stateStream.close();
  }
}
