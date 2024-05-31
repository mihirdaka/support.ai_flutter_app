import 'package:json_annotation/json_annotation.dart';
import 'package:supportu_flutter_app/data/base.dart';
import 'package:supportu_flutter_app/data/user.dart';

part 'auth.g.dart';

@JsonSerializable()
class RegisterResponse extends Base {
  @JsonKey(name: 'data')
  UserModel? userModel;

  RegisterResponse({this.userModel});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}
