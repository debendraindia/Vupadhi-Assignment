// To parse this JSON data, do
//
//     final getAllServiceListModel = getAllServiceListModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';

GetAllServiceListModel getAllServiceListModelFromJson(String str) => GetAllServiceListModel.fromJson(json.decode(str));

String getAllServiceListModelToJson(GetAllServiceListModel data) => json.encode(data.toJson());

class GetAllServiceListModel {
  final String? code;
  final String? status;
  final String? message;
  final List<Datum>? data;

  GetAllServiceListModel({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  factory GetAllServiceListModel.fromJson(Map<String, dynamic> json) => GetAllServiceListModel(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  final int? id;
  final dynamic applicationNo;
  final String? categoryName;
  final String? serviceName;
  final String? image;
  final int? status;
  final String? createdBy;
  final dynamic description;
  final String? field1;
  final String? field2;
  final String? field3;
  final String? field4;
  final String? field5;
  final String? field6;
  final String? field7;
  final String? field8;
  final String? field9;
  final String? field10;
  final String? field11;
  final String? field12;
  final String? field13;
  final String? field14;
  final String? field15;
  final dynamic field16;
  final dynamic field17;
  final dynamic field18;
  final dynamic createdDate;
  final dynamic updateDate;
  final dynamic updateBy;

  Datum({
    this.id,
    this.applicationNo,
    this.categoryName,
    this.serviceName,
    this.image,
    this.status,
    this.createdBy,
    this.description,
    this.field1,
    this.field2,
    this.field3,
    this.field4,
    this.field5,
    this.field6,
    this.field7,
    this.field8,
    this.field9,
    this.field10,
    this.field11,
    this.field12,
    this.field13,
    this.field14,
    this.field15,
    this.field16,
    this.field17,
    this.field18,
    this.createdDate,
    this.updateDate,
    this.updateBy,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["Id"],
    applicationNo: json["ApplicationNo"],
    categoryName: json["CategoryName"],
    serviceName: json["ServiceName"],
    image: json["Image"],
    status: json["Status"],
    createdBy: json["CreatedBy"],
    description: json["Description"],
    field1: json["field1"],
    field2: json["field2"],
    field3: json["field3"],
    field4: json["field4"],
    field5: json["field5"],
    field6: json["field6"],
    field7: json["field7"],
    field8: json["field8"],
    field9: json["field9"],
    field10: json["field10"],
    field11: json["field11"],
    field12: json["field12"],
    field13: json["field13"],
    field14: json["field14"],
    field15: json["field15"],
    field16: json["field16"],
    field17: json["field17"],
    field18: json["field18"],
    createdDate: json["CreatedDate"],
    updateDate: json["UpdateDate"],
    updateBy: json["UpdateBy"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "ApplicationNo": applicationNo,
    "CategoryName": categoryName,
    "ServiceName": serviceName,
    "Image": image,
    "Status": status,
    "CreatedBy": createdBy,
    "Description": description,
    "field1": field1,
    "field2": field2,
    "field3": field3,
    "field4": field4,
    "field5": field5,
    "field6": field6,
    "field7": field7,
    "field8": field8,
    "field9": field9,
    "field10": field10,
    "field11": field11,
    "field12": field12,
    "field13": field13,
    "field14": field14,
    "field15": field15,
    "field16": field16,
    "field17": field17,
    "field18": field18,
    "CreatedDate": createdDate,
    "UpdateDate": updateDate,
    "UpdateBy": updateBy,
  };
  Uint8List? getImageBytes() {
    if (image != null && image!.startsWith('data:image')) {
      // Extract the base64 part of the image data
      String base64String = image!.split(',').last;
      return base64Decode(base64String);
    }
    return null;
  }
}
