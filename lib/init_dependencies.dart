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
import 'package:ecommerceapp/features/category/data/datasources/category_remote_data_source.dart';
import 'package:ecommerceapp/features/category/data/repositories/category_repository_impl.dart';
import 'package:ecommerceapp/features/category/domain/repositories/category_repository.dart';
import 'package:ecommerceapp/features/category/domain/usecases/get_all_categories.dart';
import 'package:ecommerceapp/features/category/domain/usecases/get_category_products.dart';
import 'package:ecommerceapp/features/category/presentation/bloc/category_cubit.dart';
import 'package:ecommerceapp/features/category/presentation/bloc/category_products_cubit.dart';
import 'package:ecommerceapp/features/home/data/datasources/home_remote_data_source.dart';
import 'package:ecommerceapp/features/home/data/repositories/home_repository_impl.dart';
import 'package:ecommerceapp/features/home/domain/repositories/home_repository.dart';
import 'package:ecommerceapp/features/home/domain/usecases/get_home_data.dart';
import 'package:ecommerceapp/features/home/presentation/bloc/home_cubit.dart';
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
  _initCategory();
  _initHome();
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

void _initCategory() {
  serviceLocator
    // Data Source
    ..registerFactory<CategoryRemoteDataSource>(
      () => CategoryRemoteDataSourceImpl(serviceLocator()),
    )
    // Repository
    ..registerFactory<CategoryRepository>(
      () => CategoryRepositoryImpl(serviceLocator()),
    )
    // Use Cases
    ..registerFactory(() => GetAllCategories(serviceLocator()))
    ..registerFactory(() => GetCategoryProducts(serviceLocator()))
    // Cubits
    ..registerLazySingleton(
      () => CategoryCubit(getAllCategories: serviceLocator()),
    )
    ..registerFactory(
      () => CategoryProductsCubit(getCategoryProducts: serviceLocator()),
    );
}

void _initHome() {
  serviceLocator
    // Data Source
    ..registerFactory<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(serviceLocator()),
    )
    // Repository
    ..registerFactory<HomeRepository>(
      () => HomeRepositoryImpl(serviceLocator()),
    )
    // Use Cases
    ..registerFactory(() => GetHomeData(serviceLocator()))
    // Cubit
    ..registerFactory(() => HomeCubit(getHomeData: serviceLocator()));
}
