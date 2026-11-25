// initDependencies() — registers all GetIt service-locator bindings.

import 'package:ecommerceapp/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:ecommerceapp/core/network/api_client.dart';
import 'package:ecommerceapp/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:ecommerceapp/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ecommerceapp/features/auth/domain/repositories/auth_repository.dart';
import 'package:ecommerceapp/features/auth/domain/usecases/send_otp.dart';
import 'package:ecommerceapp/features/auth/domain/usecases/sign_up.dart';
import 'package:ecommerceapp/features/auth/domain/usecases/user_login.dart';
import 'package:ecommerceapp/features/auth/domain/usecases/verify_otp.dart';
import 'package:ecommerceapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // External / Core async dependencies
  final sharedPreferences = await SharedPreferences.getInstance();

  serviceLocator
    // Core
    ..registerLazySingleton(() => sharedPreferences)
    ..registerLazySingleton(() => http.Client())
    ..registerLazySingleton(() => AppUserCubit())
    ..registerLazySingleton(
      () => ApiClient(
        client: serviceLocator(),
        getToken: () async => sharedPreferences.getString('auth_token'),
      ),
    );

  // Features
  _initAuth();
}

void _initAuth() {
  serviceLocator
    // Data Source
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(serviceLocator()),
    )
    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: serviceLocator(),
        sharedPreferences: serviceLocator(),
      ),
    )
    // Use Cases
    ..registerFactory(() => SignUp(serviceLocator()))
    ..registerFactory(() => UserLogin(serviceLocator()))
    ..registerFactory(() => SendOtp(serviceLocator()))
    ..registerFactory(() => VerifyOtp(serviceLocator()))
    // BLoC
    ..registerLazySingleton(
      () => AuthBloc(
        signUp: serviceLocator(),
        userLogin: serviceLocator(),
        sendOtp: serviceLocator(),
        verifyOtp: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}
