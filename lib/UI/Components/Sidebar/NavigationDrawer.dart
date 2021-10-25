import 'package:evtp/UI/Components/Bluetooth/bluetoothInterface.dart';
import 'package:evtp/UI/Screens/data_collection.dart';
import 'package:evtp/UI/Components/Sliding%20Panel/SlidingPanel.dart';
import 'package:evtp/UI/Screens/home.dart';
import 'package:evtp/UI/Components/Sidebar/UserStatus.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.white),
              child: Row(
                children: [
                  UserStatus(),
                  Expanded(
                    child: Align(
                        alignment: Alignment.topRight, child: CloseButton()),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Card(
                    child: ListTile(
                        title: Text('Map'),
                        subtitle: Text('View the map'),
                        leading: Icon(Icons.park),
                        trailing: Icon(Icons.arrow_forward),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) => Home()));
                        }),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('New Route'),
                      subtitle: Text('Plan a new trip'),
                      leading: Icon(Icons.map),
                      trailing: Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(
                                builder: (BuildContext context) => Home()))
                            .then((value) => slideController.open());
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                        title: Text('Log Trip'),
                        subtitle: Text('Log a new trip to the database'),
                        leading: Icon(Icons.data_usage),
                        trailing: Icon(Icons.arrow_forward),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  DataCollection()));
                        }),
                  ),
                  Card(
                    child: ListTile(
                        title: Text('BLE TESTING '),
                        subtitle: Text('TESTING BLE'),
                        leading: Icon(Icons.data_usage),
                        trailing: Icon(Icons.arrow_forward),
                        onTap: () {
                          //Navigator.pop(context);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  BLEInterface()));
                        }),
                  ),
                ],
              ),
            ),
            Card(
              child: ListTile(
                  title: Text('Settings'),
                  trailing: Icon(Icons.settings),
                  onTap: null),
            ),
          ],
        ),
      ),
    );
  }
}
