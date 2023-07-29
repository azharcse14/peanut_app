import 'package:peanut_app/features/auth/domain/entities/login_entity.dart';

class LoginModel extends LoginEntity {
  const LoginModel({
    required super.result,
    required super.token,
  });

  LoginModel copyWith({
    final bool? result,
    final String? token,
  }) {
    return LoginModel(
      result: result ?? this.result,
      token: token ?? this.token,
    );
  }

  factory LoginModel.init() => const LoginModel(
    result: false,
    token: '',
      );

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      LoginModel(
        result: json["result"] ?? false,
        token: json["token"] ?? '',
      );
}
