// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Base _$BaseFromJson(Map<String, dynamic> json) => Base(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      additionalData: json['additional_data'] as Map<String, dynamic>?,
      error: json['error'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$BaseToJson(Base instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'additional_data': instance.additionalData,
      'error': instance.error,
    };
