// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResponse _$RegisterResponseFromJson(Map<String, dynamic> json) =>
    RegisterResponse(
      userModel: json['data'] == null
          ? null
          : UserModel.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..status = json['status'] as bool?
      ..message = json['message'] as String?
      ..additionalData = json['additional_data'] as Map<String, dynamic>?
      ..error = json['error'] as Map<String, dynamic>?;

Map<String, dynamic> _$RegisterResponseToJson(RegisterResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'additional_data': instance.additionalData,
      'error': instance.error,
      'data': instance.userModel,
    };
