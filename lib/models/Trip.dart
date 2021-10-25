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

/** This is an auto generated class representing the Trip type in your schema. */
@immutable
class Trip extends Model {
  static const classType = const _TripModelType();
  final String id;
  final String start;
  final String end;
  final String usersID;
  final List<TripBreakdown>? TripBreakdowns;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Trip._internal(
      {required this.id,
      required this.start,
      required this.end,
      required this.usersID,
      required this.TripBreakdowns});

  factory Trip(
      {required String id,
      required String start,
      required String end,
      required String usersID,
      required List<TripBreakdown>? TripBreakdowns}) {
    return Trip._internal(
        id: id == null ? UUID.getUUID() : id,
        start: start,
        end: end,
        usersID: usersID,
        TripBreakdowns: TripBreakdowns != null
            ? List.unmodifiable(TripBreakdowns)
            : TripBreakdowns);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Trip &&
        id == other.id &&
        start == other.start &&
        end == other.end &&
        usersID == other.usersID &&
        DeepCollectionEquality().equals(TripBreakdowns, other.TripBreakdowns);
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Trip {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("start=" + "$start" + ", ");
    buffer.write("end=" + "$end" + ", ");
    buffer.write("usersID=" + "$usersID");
    buffer.write("}");

    return buffer.toString();
  }

  Trip copyWith(
      {required String id,
      required String start,
      required String end,
      required String usersID,
      required List<TripBreakdown>? TripBreakdowns}) {
    return Trip(
        id: id,
        start: start,
        end: end,
        usersID: usersID,
        TripBreakdowns: TripBreakdowns ?? this.TripBreakdowns);
  }

  Trip.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        start = json['start'],
        end = json['end'],
        usersID = json['usersID'],
        TripBreakdowns = json['TripBreakdowns'] is List
            ? (json['TripBreakdowns'] as List)
                .map((e) =>
                    TripBreakdown.fromJson(new Map<String, dynamic>.from(e)))
                .toList()
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'start': start,
        'end': end,
        'usersID': usersID,
        'TripBreakdowns': TripBreakdowns?.map((e) => e.toJson()).toList()
      };

  static final QueryField ID = QueryField(fieldName: "trip.id");
  static final QueryField START = QueryField(fieldName: "start");
  static final QueryField END = QueryField(fieldName: "end");
  static final QueryField USERSID = QueryField(fieldName: "usersID");
  static final QueryField TRIPBREAKDOWNS = QueryField(
      fieldName: "TripBreakdowns",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (TripBreakdown).toString()));
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Trip";
    modelSchemaDefinition.pluralName = "Trips";

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
        key: Trip.START,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Trip.END,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Trip.USERSID,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: Trip.TRIPBREAKDOWNS,
        isRequired: false,
        ofModelName: (TripBreakdown).toString(),
        associatedKey: TripBreakdown.TRIPID));
  });
}

class _TripModelType extends ModelType<Trip> {
  const _TripModelType();

  @override
  Trip fromJson(Map<String, dynamic> jsonData) {
    return Trip.fromJson(jsonData);
  }
}
