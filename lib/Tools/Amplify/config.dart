//Amplify
import 'package:evtp/models/ModelProvider.dart';

import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:evtp/amplifyconfiguration.dart';

bool _amplifyConfigured = false;

void configureAmplify() async {
  if (!_amplifyConfigured) {
    Amplify.addPlugin(AmplifyAPI());
    Amplify.addPlugin(AmplifyDataStore(modelProvider: ModelProvider.instance));
    Amplify.addPlugin(AmplifyAuthCognito());
    _amplifyConfigured = true;
  }

  try {
    await Amplify.configure(amplifyconfig);
    _amplifyConfigured = true;
  } catch (e) {
    print(e);
  }
}
