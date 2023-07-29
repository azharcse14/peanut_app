import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peanut_app/features/auth/domain/entities/login_entity.dart';
import 'package:peanut_app/features/auth/domain/use_cases/login_usecase.dart';
import 'package:peanut_app/core/error/failure.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;

  LoginEntity? _loginEntity;

  LoginEntity? get loginEntity => _loginEntity;

  AuthBloc({
    required this.loginUseCase,
  }) : super(AuthInitial()) {
    on<Login>((event, emit) async {
      emit(AuthLoading());
      Either<Failure, LoginEntity> result = await loginUseCase(
        userId: event.userId,
        password: event.password,
      );
      result.fold((l) => emit(AuthError(error: l.message)), (r) {
        _loginEntity = r;
        emit(LoginSuccess(loginEntity: r));
      });
    });
  }
}
