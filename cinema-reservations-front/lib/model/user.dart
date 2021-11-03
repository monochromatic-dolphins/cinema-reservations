import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

class Role {
  static const String employee = 'employee';
  static const String regular = 'regular';
}

@JsonSerializable()
class User {
  final int id;
  final String login;
  final String role;

  User({
    required this.id,
    required this.login,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}