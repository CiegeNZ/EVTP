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

import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the Users type in your schema. */
@immutable
class Users extends Model {
  static const classType = const _UsersModelType();
  final String id;
  final String name;
  final List<Trip>? Trips;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Users._internal(
      {required this.id, required this.name, required this.Trips});

  factory Users(
      {required String id, required String name, required List<Trip>? Trips}) {
    return Users._internal(
        id: id == null ? UUID.getUUID() : id,
        name: name,
        Trips: Trips != null ? List.unmodifiable(Trips) : Trips);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Users &&
        id == other.id &&
        name == other.name &&
        DeepCollectionEquality().equals(Trips, other.Trips);
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Users {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$name");
    buffer.write("}");

    return buffer.toString();
  }

  Users copyWith(
      {required String id, required String name, required List<Trip>? Trips}) {
    return Users(id: id, name: name, Trips: Trips ?? this.Trips);
  }

  Users.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        Trips = json['Trips'] is List
            ? (json['Trips'] as List)
                .map((e) => Trip.fromJson(new Map<String, dynamic>.from(e)))
                .toList()
            : null;

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'Trips': Trips?.map((e) => e.toJson()).toList()};

  static final QueryField ID = QueryField(fieldName: "users.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField TRIPS = QueryField(
      fieldName: "Trips",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Trip).toString()));
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Users";
    modelSchemaDefinition.pluralName = "Users";

    modelSchemaDefinition.authRules = [
      AuthRule(authStrategy: AuthStrategy.PUBLIC, operations: [
        ModelOperation.CREATE,
        ModelOperation.UPDATE,
        ModelOperation.DELETE,
        ModelOperation.READ
      ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Users.NAME,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: Users.TRIPS,
        isRequired: false,
        ofModelName: (Trip).toString(),
        associatedKey: Trip.USERSID));
  });
}

class _UsersModelType extends ModelType<Users> {
  const _UsersModelType();

  @override
  Users fromJson(Map<String, dynamic> jsonData) {
    return Users.fromJson(jsonData);
  }
}
