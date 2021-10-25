import 'package:evtp/main.dart';
import 'package:evtp/Tools/Amplify/auth.dart';
import 'package:flutter/material.dart';
import 'package:validated/validated.dart' as validate;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final email = TextEditingController();
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
              child: Form(
                child: Column(
                  children: [
                    Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: TextFormField(
                          controller: email,
                          onChanged: (value) {
                            if (!validate.isEmail(value)) {
                              setEmailError("Please enter a valid email");
                            } else {
                              setState(() {
                                isEmailValid = true;
                              });
                            }
                          },
                          onTap: () {
                            FocusScope.of(context).unfocus();
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            errorText: isEmailValid ? null : error,
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.supervised_user_circle),
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
                    SizedBox(height: 20),
                    Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: TextFormField(
                          controller: password,
                          onChanged: (value) {
                            if (!validate.isLength(value, 6, 32)) {
                              setPassError(
                                  "Password must be 6 - 32 characters");
                            } else {
                              setState(() {
                                isPassValid = true;
                              });
                            }
                          },
                          onTap: () {
                            FocusScope.of(context).unfocus();
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            errorText: isPassValid ? null : error,
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
                          await Auth.tryLogin(email.text, password.text);

                          //check if correct
                          if (Auth.getSignedIn() == true) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (BuildContext context) => EVTP(),
                              ),
                            );
                          } else {
                            setPassError("Password is incorrect");
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Login",
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
