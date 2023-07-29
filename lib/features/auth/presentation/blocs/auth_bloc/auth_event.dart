part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class Login extends AuthEvent {
  final int userId;
  final String password;

  const Login({
    required this.userId,
    required this.password,
  });
}


