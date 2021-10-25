import 'package:evtp/UI/Users/loginForm.dart';
import 'package:evtp/UI/Users/newUserForm.dart';
import 'package:evtp/main.dart';
import 'package:flutter/material.dart';

class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  bool login = true;

  @override
  Widget build(BuildContext context) {
    if (login) {
      return MaterialApp(
        title: 'EVTP Login',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.teal),
        home: Scaffold(
          appBar: AppBar(
            title: Text("EVTP Login"),
            leading: BackButton(onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) => EVTP()));
            }),
          ),
          body: Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 200),
                Login(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          login = false;
                        });
                        print("swapping to register");
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.teal),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Create New Account",
                            style: TextStyle(fontSize: 18),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return MaterialApp(
        title: 'EVTP Register',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.teal),
        home: Scaffold(
          appBar: AppBar(
            title: Text("EVTP Register"),
            leading: BackButton(onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) => EVTP()));
            }),
          ),
          body: Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 160),
                NewUser(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          login = true;
                        });
                        print("swapping to login");
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.teal),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Have Existing Account?",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
