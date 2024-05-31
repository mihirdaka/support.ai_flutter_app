import 'package:json_annotation/json_annotation.dart';

part 'base.g.dart';

@JsonSerializable()
class Base {
  @JsonKey(name: 'status')
  bool? status;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'additional_data')
  Map<String, dynamic>? additionalData;

  @JsonKey(name: 'error')
  Map<String, dynamic>? error;
  Base({
    this.status,
    this.message,
    this.additionalData,
    this.error,
  });

  factory Base.fromJson(Map<String, dynamic> json) => _$BaseFromJson(json);
}
