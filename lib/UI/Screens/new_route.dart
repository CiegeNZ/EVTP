import 'package:flutter/material.dart';

import 'package:evtp/UI/Components/Sidebar/NavigationDrawer.dart';

class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EVTP App',
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          title: Text("EVTP App - New Navigation"),
        ),
        drawer: NavigationDrawer(),
        body: Container(
          child: Stack(
            children: <Widget>[Text("New Navigation Page")],
          ),
        ),
      ),
    );
  }
}
