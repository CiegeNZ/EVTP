import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';

class VerifyEmailDialogBox extends StatefulWidget {
  @override
  _VerifyEmailDialogBoxState createState() => _VerifyEmailDialogBoxState();
}

class _VerifyEmailDialogBoxState extends State<VerifyEmailDialogBox> {
  var loading = false;

  final verify = new TextEditingController();
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 10),
                      blurRadius: 10),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          icon: Icon(Icons.close),
                          color: Colors.red,
                          iconSize: 32,
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "Email Verification",
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Enter verification code sent to email",
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 11,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: PinCodeFields(
                    responsive: true,
                    length: 6,
                    keyboardType: TextInputType.number,
                    controller: verify,
                    focusNode: focusNode,
                    onComplete: (code) async {
                      // Your logic with pin code
                      //Auth.confirmSignUp(code);
                      //Validate account...

                      print(code);
                    },
                  ),
                ),
                SizedBox(
                  height: 11,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() => loading = true);
                        //already validated... pretend...
                        Future.delayed(const Duration(milliseconds: 600), () {
                          Navigator.of(context).pop();
                        });
                      },
                      child: loading
                          ? Text(
                              "...",
                              style: TextStyle(fontSize: 24),
                            )
                          : Text(
                              "Verify",
                              style: TextStyle(fontSize: 24),
                            )),
                ),
                SizedBox(
                  height: 18,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.teal),
                      onPressed: () {
                        //generate new code?

                        //Navigator.of(context).pop();
                      },
                      child: Text(
                        "Didn't recieve a code?",
                        style: TextStyle(fontSize: 11),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
