import 'dart:io';

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:supportu_flutter_app/data/base.dart';

part 'chat.g.dart';

@HiveType(typeId: 4)
enum Role {
  @HiveField(0)
  user,
  @HiveField(1)
  assistant,
}

@JsonSerializable()
class ChatResponse extends Base {
  @JsonKey(name: 'data')
  ChatMessage? messages;

  ChatResponse({
    this.messages,
  });

  factory ChatResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatResponseFromJson(json);
}

@JsonSerializable()
@HiveType(typeId: 2)
class ChatMessage extends HiveObject {
  @JsonKey(name: 'id')
  @HiveField(0)
  int? id;

  @JsonKey(name: 'content')
  @HiveField(1)
  String? message;

  @JsonKey(name: 'role')
  @HiveField(2)
  Role? role;

  @JsonKey(name: 'timeStamp')
  @HiveField(3)
  DateTime? timeStamp;

  @JsonKey(ignore: true)
  // @HiveField(4)
  File? audioFile;

  @JsonKey(includeFromJson: false)
  // @HiveField(4)
  bool? isAudio;

  ChatMessage({
    this.id,
    this.message,
    this.role,
    this.timeStamp,
    this.audioFile,
    this.isAudio = false,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);
}

@JsonSerializable()
@HiveType(typeId: 3)
class Sessions extends HiveObject {
  @HiveField(0)
  int? sessionId;
  @HiveField(1)
  List<ChatMessage>? messages;

  Sessions({
    this.sessionId,
    this.messages,
  });

  factory Sessions.fromJson(Map<String, dynamic> json) =>
      _$SessionsFromJson(json);
}
