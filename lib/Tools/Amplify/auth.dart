import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:evtp/UI/Components/Sidebar/UserStatus.dart';

late var currentUser;

class Auth {
  static Future<bool> getSignedIn() async {
    var authSession = await Amplify.Auth.fetchAuthSession();
    return authSession.isSignedIn;
  }

  static Future<void> _getUserName() async {
    try {
      var res = await Amplify.Auth.fetchUserAttributes();
      res.forEach((element) {
        if (element.userAttributeKey == "name") {
          print("Name found: " + element.value);
          currentUser = element.value;
        }
      });
    } on AuthException catch (e) {
      print(e.message);
      currentUser = "No name found";
    }
  }

  static String getUserName() {
    return currentUser;
  }

  static Future<void> tryLogin(String email, String password) async {
    try {
      SignInResult res = await Amplify.Auth.signIn(
        username: email.trim(),
        password: password.trim(),
      );
      currentUser = _getUserName();
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  static Future<bool> signUp(name, password, email) async {
    try {
      Map<String, String> userAttributes = {
        'name': name,
        'email': email,
        // additional attributes as needed
      };

      SignUpResult res = await Amplify.Auth.signUp(
          username: email,
          password: password,
          options: CognitoSignUpOptions(userAttributes: userAttributes));

      currentUser = email;

      return (res.isSignUpComplete);
    } on AuthException catch (e) {
      print(e.message);
      return (false);
    }
  }

  static Future<void> confirmSignUp(code) async {
    try {
      SignUpResult res = await Amplify.Auth.confirmSignUp(
          username: currentUser, confirmationCode: code);

      print(res);
    } catch (error) {
      print('error confirming sign up: ' + error.toString());
    }
  }

  static Future<void> logOut() async {
    try {
      SignOutResult res = await Amplify.Auth.signOut();
      print(res);
    } on AuthException catch (e) {
      print(e.message);
    }
  }
}
