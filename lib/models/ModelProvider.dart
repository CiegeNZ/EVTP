/*
* Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// ignore_for_file: public_member_api_docs

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'Trip.dart';
import 'TripBreakdown.dart';
import 'Users.dart';

export 'Trip.dart';
export 'TripBreakdown.dart';
export 'Users.dart';

class ModelProvider implements ModelProviderInterface {
  @override
  String version = "bba85a13d66f760b44af4643905a5dc8";
  @override
  List<ModelSchema> modelSchemas = [
    Trip.schema,
    TripBreakdown.schema,
    Users.schema
  ];
  static final ModelProvider _instance = ModelProvider();

  static ModelProvider get instance => _instance;

  ModelType getModelTypeByModelName(String modelName) {
    switch (modelName) {
      case "Trip":
        {
          return Trip.classType;
        }
        break;
      case "TripBreakdown":
        {
          return TripBreakdown.classType;
        }
        break;
      case "Users":
        {
          return Users.classType;
        }
        break;
      default:
        {
          throw Exception(
              "Failed to find model in model provider for model name: " +
                  modelName);
        }
    }
  }
}
