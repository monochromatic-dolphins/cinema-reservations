import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

class Role {
  static const String employee = 'ADMIN';
  static const String regular = 'USER';
}

@JsonSerializable()
class User {
  final int userId;
  final String login;
  final String role;

  User({
    required this.userId,
    required this.login,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}