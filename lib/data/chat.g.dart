// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatMessageAdapter extends TypeAdapter<ChatMessage> {
  @override
  final int typeId = 2;

  @override
  ChatMessage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatMessage(
      id: fields[0] as int?,
      message: fields[1] as String?,
      role: fields[2] as Role?,
      timeStamp: fields[3] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, ChatMessage obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.role)
      ..writeByte(3)
      ..write(obj.timeStamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatMessageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SessionsAdapter extends TypeAdapter<Sessions> {
  @override
  final int typeId = 3;

  @override
  Sessions read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Sessions(
      sessionId: fields[0] as int?,
      messages: (fields[1] as List?)?.cast<ChatMessage>(),
    );
  }

  @override
  void write(BinaryWriter writer, Sessions obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.sessionId)
      ..writeByte(1)
      ..write(obj.messages);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RoleAdapter extends TypeAdapter<Role> {
  @override
  final int typeId = 4;

  @override
  Role read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Role.user;
      case 1:
        return Role.assistant;
      default:
        return Role.user;
    }
  }

  @override
  void write(BinaryWriter writer, Role obj) {
    switch (obj) {
      case Role.user:
        writer.writeByte(0);
        break;
      case Role.assistant:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatResponse _$ChatResponseFromJson(Map<String, dynamic> json) => ChatResponse(
      messages: json['data'] == null
          ? null
          : ChatMessage.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..status = json['status'] as bool?
      ..message = json['message'] as String?
      ..additionalData = json['additional_data'] as Map<String, dynamic>?
      ..error = json['error'] as Map<String, dynamic>?;

Map<String, dynamic> _$ChatResponseToJson(ChatResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'additional_data': instance.additionalData,
      'error': instance.error,
      'data': instance.messages,
    };

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) => ChatMessage(
      id: (json['id'] as num?)?.toInt(),
      message: json['content'] as String?,
      role: $enumDecodeNullable(_$RoleEnumMap, json['role']),
      timeStamp: json['timeStamp'] == null
          ? null
          : DateTime.parse(json['timeStamp'] as String),
    );

Map<String, dynamic> _$ChatMessageToJson(ChatMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.message,
      'role': _$RoleEnumMap[instance.role],
      'timeStamp': instance.timeStamp?.toIso8601String(),
    };

const _$RoleEnumMap = {
  Role.user: 'user',
  Role.assistant: 'assistant',
};

Sessions _$SessionsFromJson(Map<String, dynamic> json) => Sessions(
      sessionId: (json['sessionId'] as num?)?.toInt(),
      messages: (json['messages'] as List<dynamic>?)
          ?.map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SessionsToJson(Sessions instance) => <String, dynamic>{
      'sessionId': instance.sessionId,
      'messages': instance.messages,
    };
