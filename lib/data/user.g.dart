// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 1;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      userId: fields[0] as int?,
      firstName: fields[1] as String?,
      lastName: fields[2] as String?,
      userEmail: fields[3] as String?,
      userMobile: fields[4] as String?,
      firebaseUid: fields[5] as String?,
      createdDate: fields[6] as String?,
      accessToken: fields[7] as String?,
      userName: fields[8] as String?,
      dateOfBirth: fields[9] as DateTime?,
      profileUrl: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.userEmail)
      ..writeByte(4)
      ..write(obj.userMobile)
      ..writeByte(5)
      ..write(obj.firebaseUid)
      ..writeByte(6)
      ..write(obj.createdDate)
      ..writeByte(7)
      ..write(obj.accessToken)
      ..writeByte(8)
      ..write(obj.userName)
      ..writeByte(9)
      ..write(obj.dateOfBirth)
      ..writeByte(10)
      ..write(obj.profileUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      fields[0] as UserModel,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.userModel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      userId: (json['id'] as num?)?.toInt(),
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      userEmail: json['email'] as String?,
      userMobile: json['user_mobile'] as String?,
      firebaseUid: json['firebase_uid'] as String?,
      createdDate: json['createdAt'] as String?,
      accessToken: json['token'] as String?,
      userName: json['userName'] as String?,
      dateOfBirth: _$JsonConverterFromJson<String, DateTime>(
          json['dateOfBirth'], const CustomDateTimeConverter().fromJson),
      profileUrl: json['profileUrl'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.userId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.userEmail,
      'user_mobile': instance.userMobile,
      'firebase_uid': instance.firebaseUid,
      'createdAt': instance.createdDate,
      'token': instance.accessToken,
      'userName': instance.userName,
      'dateOfBirth': _$JsonConverterToJson<String, DateTime>(
          instance.dateOfBirth, const CustomDateTimeConverter().toJson),
      'profileUrl': instance.profileUrl,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
