import 'package:evtp/UI/Users/VerifyEmailDialogBox.dart';
import 'package:flutter/material.dart';
import 'package:validated/validated.dart' as validate;

class NewUser extends StatefulWidget {
  @override
  _NewUserState createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();

  String error = "Error not set";
  bool isEmailValid = true;
  bool isPassValid = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Center(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.75,
              margin: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
              color: Colors.white,
              child: Form(
                child: Column(
                  children: [
                    Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: TextFormField(
                          controller: name,
                          validator: (value) {
                            if (!validate.isAlpha(value!)) {
                              return ("Please enter a valid name (letters only)");
                            }
                          },
                          onTap: () {
                            FocusScope.of(context).unfocus();
                          },
                          decoration: InputDecoration(
                            labelText: 'Name',
                            prefixIcon: Icon(Icons.supervised_user_circle),
                            suffix: IconButton(
                                icon: Icon(Icons.cancel),
                                onPressed: () {
                                  name.clear();
                                  FocusScope.of(context).unfocus();
                                }),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: TextFormField(
                          controller: email,
                          onTap: () {
                            FocusScope.of(context).unfocus();
                          },
                          validator: (value) {
                            if (!validate.isEmail(value!)) {
                              return ("Please enter a valid email");
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                            suffix: IconButton(
                                icon: Icon(Icons.cancel),
                                onPressed: () {
                                  email.clear();
                                  FocusScope.of(context).unfocus();
                                }),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: TextFormField(
                          controller: password,
                          validator: (value) {
                            if (!validate.isLength(value!, 6, 32)) {
                              return ("Please enter a valid password (6-32 characters)");
                            }
                          },
                          onTap: () {
                            FocusScope.of(context).unfocus();
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                            suffix: IconButton(
                                icon: Icon(Icons.cancel),
                                onPressed: () {
                                  password.clear();
                                  FocusScope.of(context).unfocus();
                                }),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          //New User
                          // Future<bool> signup = Auth.signUp(
                          //     name.text, password.text, email.text);
                          //Handle Existing emails....

                          //Assuming sign up suceeded?
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return VerifyEmailDialogBox();
                              }).then((value) {
                            //Check registered
                          });

                          //print(signup);
                          print("Registering new user");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Register",
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
        ),
      ],
    );
  }

  void setEmailError(String _error) {
    setState(() {
      isEmailValid = false;
      error = _error;
    });
  }

  void setPassError(String _error) {
    setState(() {
      isPassValid = false;
      error = _error;
    });
  }
}
