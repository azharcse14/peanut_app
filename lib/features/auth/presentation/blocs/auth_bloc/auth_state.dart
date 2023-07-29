part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final String error;

  const AuthError({required this.error});
}

class LoginSuccess extends AuthState {
  final LoginEntity loginEntity;

  const LoginSuccess({
    required this.loginEntity,
  });
}


