
import 'package:doctor_pro/model/User.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ResponseLogin.g.dart';
@JsonSerializable()
class ResponseLogin {

  String accessToken;
  User user;
  String refreshToken;

  ResponseLogin(this.accessToken, this.user, this.refreshToken);

  factory ResponseLogin.fromJson(Map<String, dynamic> json) => _$ResponseLoginFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseLoginToJson(this);

  @override
  String toString() {
    return 'ResponseLogin{accessToken: $accessToken, user: $user, refreshToken: $refreshToken}';
  }
}