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
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the TripBreakdown type in your schema. */
@immutable
class TripBreakdown extends Model {
  static const classType = const _TripBreakdownModelType();
  final String id;
  final TemporalTimestamp? timestamp;
  final String latlng;
  final String batteryStatus;
  final String batteryCharge;
  final double speed;
  final String force;
  final String elevation;
  final String acceleration;
  final String tripID;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const TripBreakdown._internal(
      {required this.id,
      required this.timestamp,
      required this.latlng,
      required this.batteryStatus,
      required this.batteryCharge,
      required this.speed,
      required this.force,
      required this.elevation,
      required this.acceleration,
      required this.tripID});

  factory TripBreakdown(
      {required String id,
      required TemporalTimestamp? timestamp,
      required String latlng,
      required String batteryStatus,
      required String batteryCharge,
      required double speed,
      required String force,
      required String elevation,
      required String acceleration,
      required String tripID}) {
    return TripBreakdown._internal(
        id: id == null ? UUID.getUUID() : id,
        timestamp: timestamp,
        latlng: latlng,
        batteryStatus: batteryStatus,
        batteryCharge: batteryCharge,
        speed: speed,
        force: force,
        elevation: elevation,
        acceleration: acceleration,
        tripID: tripID);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TripBreakdown &&
        id == other.id &&
        timestamp == other.timestamp &&
        latlng == other.latlng &&
        batteryStatus == other.batteryStatus &&
        batteryCharge == other.batteryCharge &&
        speed == other.speed &&
        force == other.force &&
        elevation == other.elevation &&
        acceleration == other.acceleration &&
        tripID == other.tripID;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("TripBreakdown {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("timestamp=" +
        (timestamp != null ? timestamp.toString() : "null") +
        ", ");
    buffer.write("latlng=" + "$latlng" + ", ");
    buffer.write("batteryStatus=" + "$batteryStatus" + ", ");
    buffer.write("batteryCharge=" + "$batteryCharge" + ", ");
    buffer.write("speed=" + (speed != null ? speed.toString() : "null") + ", ");
    buffer.write("force=" + "$force" + ", ");
    buffer.write("elevation=" + "$elevation" + ", ");
    buffer.write("acceleration=" + "$acceleration" + ", ");
    buffer.write("tripID=" + "$tripID");
    buffer.write("}");

    return buffer.toString();
  }

  TripBreakdown copyWith(
      {required String id,
      required TemporalTimestamp? timestamp,
      required String latlng,
      required String batteryStatus,
      required String batteryCharge,
      required double speed,
      required String force,
      required String elevation,
      required String acceleration,
      required String tripID}) {
    return TripBreakdown(
        id: id,
        timestamp: timestamp ?? this.timestamp,
        latlng: latlng,
        batteryStatus: batteryStatus,
        batteryCharge: batteryCharge,
        speed: speed,
        force: force,
        elevation: elevation,
        acceleration: acceleration,
        tripID: tripID);
  }

  TripBreakdown.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        timestamp = json['timestamp'] != null
            ? TemporalTimestamp.fromSeconds(json['timestamp'])
            : null,
        latlng = json['latlng'],
        batteryStatus = json['batteryStatus'],
        batteryCharge = json['batteryCharge'],
        speed = json['speed'],
        force = json['force'],
        elevation = json['elevation'],
        acceleration = json['acceleration'],
        tripID = json['tripID'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'timestamp': timestamp?.toSeconds(),
        'latlng': latlng,
        'batteryStatus': batteryStatus,
        'batteryCharge': batteryCharge,
        'speed': speed,
        'force': force,
        'elevation': elevation,
        'acceleration': acceleration,
        'tripID': tripID
      };

  static final QueryField ID = QueryField(fieldName: "tripBreakdown.id");
  static final QueryField TIMESTAMP = QueryField(fieldName: "timestamp");
  static final QueryField LATLNG = QueryField(fieldName: "latlng");
  static final QueryField BATTERYSTATUS =
      QueryField(fieldName: "batteryStatus");
  static final QueryField BATTERYCHARGE =
      QueryField(fieldName: "batteryCharge");
  static final QueryField SPEED = QueryField(fieldName: "speed");
  static final QueryField FORCE = QueryField(fieldName: "force");
  static final QueryField ELEVATION = QueryField(fieldName: "elevation");
  static final QueryField ACCELERATION = QueryField(fieldName: "acceleration");
  static final QueryField TRIPID = QueryField(fieldName: "tripID");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "TripBreakdown";
    modelSchemaDefinition.pluralName = "TripBreakdowns";

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
        key: TripBreakdown.TIMESTAMP,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.timestamp)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: TripBreakdown.LATLNG,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: TripBreakdown.BATTERYSTATUS,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: TripBreakdown.BATTERYCHARGE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: TripBreakdown.SPEED,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.double)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: TripBreakdown.FORCE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: TripBreakdown.ELEVATION,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: TripBreakdown.ACCELERATION,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: TripBreakdown.TRIPID,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class _TripBreakdownModelType extends ModelType<TripBreakdown> {
  const _TripBreakdownModelType();

  @override
  TripBreakdown fromJson(Map<String, dynamic> jsonData) {
    return TripBreakdown.fromJson(jsonData);
  }
}
