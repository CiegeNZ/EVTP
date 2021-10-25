import 'package:evtp/UI/Components/Map/GoogleMap.dart';
import 'package:evtp/UI/Components/Sidebar/NavigationDrawer.dart';
import 'package:evtp/UI/Components/Sliding%20Panel/SlidingPanel.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EVTP App',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: Scaffold(
        appBar: AppBar(
          title: Text("EVTP App"),
        ),
        drawer: NavigationDrawer(),
        body: Container(
          child: Stack(
            children: <Widget>[GoogleMap(), SlideUpPanel()],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
