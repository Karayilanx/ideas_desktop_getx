import 'package:json_annotation/json_annotation.dart';

part 'login_input.g.dart';

@JsonSerializable()
class LoginInput {
  String? email;
  String? pass;

  LoginInput({this.email, this.pass});

  factory LoginInput.fromJson(Map<String, dynamic> json) {
    return _$LoginInputFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$LoginInputToJson(this);
  }
}
