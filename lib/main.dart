// @dart=2.9
import 'package:evtp/Tools/Amplify/config.dart' as amplify;
import 'package:evtp/Tools/Location/location.dart';
import 'package:evtp/appState.dart';

import 'package:flutter/material.dart';
import 'package:evtp/UI/Screens/home.dart';

void main() {
  runApp(EVTP());
}

class EVTP extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EVTPState();
}

class _EVTPState extends State<EVTP> {
  @override
  void initState() {
    super.initState();
    startLocation();
    amplify.configureAmplify();
  }

  @override
  Widget build(BuildContext context) {
    return Home();
  }
}
