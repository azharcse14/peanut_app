import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:peanut_app/features/auth/data/data_sources/auth_data_source.dart';
import 'package:peanut_app/features/auth/data/data_sources/i_auth_data_source.dart';
import 'package:peanut_app/features/auth/data/repository/auth_repository.dart';
import 'package:peanut_app/features/auth/domain/repository/i_auth_repository.dart';
import 'package:peanut_app/features/auth/domain/use_cases/login_usecase.dart';
import 'package:peanut_app/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:peanut_app/features/home/data/data_sources/home_data_source.dart';
import 'package:peanut_app/features/home/data/data_sources/i_home_data_source.dart';
import 'package:peanut_app/features/home/data/repository/home_repository.dart';
import 'package:peanut_app/features/home/domain/repository/i_home_repository.dart';

import 'package:peanut_app/core/network/i_network_client.dart';
import 'package:peanut_app/core/network/network_client.dart';
import 'package:peanut_app/core/presentation/blocs/internet_bloc/internet_bloc.dart';
import 'package:peanut_app/core/shared_prefs/shared_prefs.dart';
import 'package:peanut_app/features/home/domain/use_cases/home_usecase.dart';
import 'package:peanut_app/features/profile/data/data_sources/phone_number/i_phone_number_data_sources.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/home/presentation/manager/home_bloc.dart';
import '../features/profile/data/data_sources/account_information/account_information_data_sources.dart';
import '../features/profile/data/data_sources/account_information/i_account_information_data_sources.dart';
import '../features/profile/data/data_sources/phone_number/phone_number_data_sources.dart';
import '../features/profile/data/repositories/account_information_repository.dart';
import '../features/profile/data/repositories/phone_number_repository.dart';
import '../features/profile/domain/repositories/i_account_information_repository.dart';
import '../features/profile/domain/repositories/i_phone_number_repository.dart';
import '../features/profile/domain/use_cases/account_information_usecase.dart';
import '../features/profile/domain/use_cases/phone_number_usecase.dart';
import '../features/profile/presentation/manager/account_information/account_information_bloc.dart';
import '../features/profile/presentation/manager/phone_number/phone_number_bloc.dart';

final injector = GetIt.instance;

Future<void> injectDependencies() async {
  //////////////-------------  CORE  ----------------------//////////////////
  injector.registerLazySingleton<Dio>(() => Dio());
  injector.registerSingletonAsync<SharedPreferencesUtils>(
      (() async => await (SharedPreferencesUtils.getInstance())));
  injector.registerSingletonAsync<SharedPreferences>(
      () async => await SharedPreferences.getInstance());
  injector.registerLazySingleton<INetworkClient>(
      () => NetworkClient(dio: injector()));

  ////////////--------------  DATASOURCES --------------------//////////////////

  injector.registerLazySingleton<IAuthDataSource>(
      () => AuthDataSource(networkClient: injector()));

  injector.registerLazySingleton<IHomeDataSource>(
      () => HomeDataSource(networkClient: injector()));

  injector.registerLazySingleton<IAccountInformationDataSource>(
      () => AccountInformationDataSource(networkClient: injector()));

  injector.registerLazySingleton<IPhoneNumberDataSource>(
      () => PhoneNumberDataSource(networkClient: injector()));

  /////////................ REPOSITORIES ....................///////////////////
  injector.registerLazySingleton<IAuthRepository>(
    () => AuthRepository(
      authDataSource: injector(),
    ),
  );

  injector.registerLazySingleton<IHomeRepository>(
    () => HomeRepository(
      homeDataSource: injector(),
    ),
  );

  injector.registerLazySingleton<IAccountInformationRepository>(
    () => AccountInformationRepository(
      accountInformationDataSource: injector(),
    ),
  );

  injector.registerLazySingleton<IPhoneNumberRepository>(
      () => PhoneNumberRepository(phoneNumberDataSource: injector()));

  /////////......................   USE CASES    ....................//////////
  injector.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(authRepository: injector()));

  injector.registerLazySingleton<HomeUseCase>(
      () => HomeUseCase(homeRepository: injector()));

  injector.registerLazySingleton<AccountInformationUseCase>(
    () => AccountInformationUseCase(
      accountInformationRepository: injector(),
    ),
  );

  injector.registerLazySingleton<PhoneNumberUseCase>(
      () => PhoneNumberUseCase(phoneNumberRepository: injector()));

  /////////---------------------    BLOCS   ------------------------////////////

  injector.registerLazySingleton<InternetBloc>(
    () => InternetBloc(),
  );

  injector.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      loginUseCase: injector(),
    ),
  );

  injector.registerLazySingleton<HomeBloc>(
    () => HomeBloc(
      homeUseCase: injector(),
    ),
  );

  injector.registerLazySingleton<AccountInformationBloc>(
    () => AccountInformationBloc(
      accountInformationUseCase: injector(),
    ),
  );

  injector.registerLazySingleton<PhoneNumberBloc>(
    () => PhoneNumberBloc(
      phoneNumberUseCase: injector(),
    ),
  );
}
