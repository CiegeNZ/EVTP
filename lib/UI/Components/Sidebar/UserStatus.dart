import 'package:amplify_flutter/amplify.dart';
import 'package:evtp/UI/Screens/user_login.dart';
import 'package:evtp/Tools/Amplify/auth.dart';
import 'package:flutter/material.dart';

class UserStatus extends StatefulWidget {
  @override
  _UserStatusState createState() => _UserStatusState();
}

class _UserStatusState extends State<UserStatus> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Auth.getSignedIn() == true) {
      return Material(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: CircleAvatar(
                      /*backgroundImage: NetworkImage(firebase?),*/
                      child: Text(Auth.getUserName()[0]),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    Auth.getUserName(),
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.blue),
              child: Text("Logout"),
              onPressed: () {
                //Log out stuff
                Auth.logOut();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Center(
                      child: Text('Logged Out!'),
                    ),
                    behavior: SnackBarBehavior.floating,
                    duration: const Duration(seconds: 5),
                  ),
                );
              },
            ),
          ],
        ),
      );
    } else {
      return Material(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: CircleAvatar(
                      /*backgroundImage: NetworkImage(firebase?),*/
                      child: Text("?"),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "No User",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.blue),
              child: Text("Log In"),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => UserLogin()));
              },
            ),
          ],
        ),
      );
    }
  }
}
