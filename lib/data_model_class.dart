// To parse this JSON data, do
//
//     final dataModelClass = dataModelClassFromJson(jsonString);

import 'dart:convert';

DataModelClass dataModelClassFromJson(String str) => DataModelClass.fromJson(json.decode(str));

String dataModelClassToJson(DataModelClass data) => json.encode(data.toJson());

class DataModelClass {
  DataModelClass({
    required this.success,
    required this.code,
    required this.data,
    this.message,
    required this.version,
    required this.env,
  });

  bool success;
  int code;
  Data data;
  dynamic message;
  String version;
  String env;

  factory DataModelClass.fromJson(Map<String, dynamic> json) => DataModelClass(
    success: json["success"],
    code: json["code"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
    version: json["version"],
    env: json["env"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "code": code,
    "data": data.toJson(),
    "message": message,
    "version": version,
    "env": env,
  };
}

class Data {
  Data({
    required this.timestamp,
    required this.ms,
  });

  DateTime timestamp;
  int ms;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    timestamp: DateTime.parse(json["timestamp"]),
    ms: json["ms"],
  );

  Map<String, dynamic> toJson() => {
    "timestamp": timestamp.toIso8601String(),
    "ms": ms,
  };
}
