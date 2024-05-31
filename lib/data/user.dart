// import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

enum Gender {
  male,
  female,
  other,
}

enum Status {
  uninitialized,
  authenticated,
  authenticating,
  unauthenticated,
  registering
}

@JsonSerializable()
@CustomDateTimeConverter()
@HiveType(typeId: 1)
class UserModel extends HiveObject {
  @JsonKey(name: 'id')
  @HiveField(0)
  int? userId;

  @JsonKey(name: 'firstName')
  @HiveField(1)
  String? firstName;

  @JsonKey(name: 'lastName')
  @HiveField(2)
  String? lastName;

  @JsonKey(name: 'email')
  @HiveField(3)
  String? userEmail;

  @JsonKey(name: 'user_mobile')
  @HiveField(4)
  String? userMobile;

  @JsonKey(name: 'firebase_uid')
  @HiveField(5)
  String? firebaseUid;

  @JsonKey(name: 'createdAt')
  @HiveField(6)
  String? createdDate;

  @JsonKey(name: 'token')
  @HiveField(7)
  String? accessToken;

  @JsonKey(name: 'userName')
  @HiveField(8)
  String? userName;

  @JsonKey(name: 'dateOfBirth')
  @HiveField(9)
  DateTime? dateOfBirth;

  @JsonKey(name: 'profileUrl')
  @HiveField(10)
  String? profileUrl;

  UserModel({
    this.userId,
    this.firstName,
    this.lastName,
    this.userEmail,
    this.userMobile,
    this.firebaseUid,
    this.createdDate,
    this.accessToken,
    this.userName,
    this.dateOfBirth,
    this.profileUrl,
    // this.profile,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  // @override
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@HiveType(typeId: 0)
class User extends HiveObject {
  // @HiveField(0)
  Status? status = Status.uninitialized;

  @HiveField(0)
  UserModel userModel;

  // @HiveField(2)
  bool get isSignedIn => status == Status.authenticated;

  User(this.userModel, {this.status});
}

class CustomDateTimeConverter implements JsonConverter<DateTime, String> {
  const CustomDateTimeConverter();

  @override
  DateTime fromJson(String json) {
    if (json.contains(".")) {
      json = json.substring(0, json.length - 1);
    }

    return DateTime.parse(json);
  }

  @override
  String toJson(DateTime json) => json.toIso8601String();
}
