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
import 'package:ecommerceapp/features/cart/data/datasources/cart_remote_data_source.dart';
import 'package:ecommerceapp/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:ecommerceapp/features/cart/domain/repositories/cart_repository.dart';
import 'package:ecommerceapp/features/cart/domain/usecases/add_to_cart.dart';
import 'package:ecommerceapp/features/cart/domain/usecases/get_cart_items.dart';
import 'package:ecommerceapp/features/cart/domain/usecases/remove_from_cart.dart';
import 'package:ecommerceapp/features/cart/domain/usecases/update_cart_quantity.dart';
import 'package:ecommerceapp/features/cart/presentation/bloc/cart_cubit.dart';
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
import 'package:ecommerceapp/features/product/data/datasources/product_remote_data_source.dart';
import 'package:ecommerceapp/features/product/data/repositories/product_repository_impl.dart';
import 'package:ecommerceapp/features/product/domain/repositories/product_repository.dart';
import 'package:ecommerceapp/features/product/domain/usecases/create_review.dart';
import 'package:ecommerceapp/features/product/domain/usecases/get_product_details.dart';
import 'package:ecommerceapp/features/product/domain/usecases/get_product_reviews.dart';
import 'package:ecommerceapp/features/product/presentation/bloc/product_cubit.dart';
import 'package:ecommerceapp/features/product/presentation/bloc/review_cubit.dart';
import 'package:ecommerceapp/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:ecommerceapp/features/wishlist/data/datasources/wishlist_remote_data_source.dart';
import 'package:ecommerceapp/features/wishlist/data/repositories/wishlist_repository_impl.dart';
import 'package:ecommerceapp/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:ecommerceapp/features/wishlist/domain/usecases/add_to_wishlist.dart';
import 'package:ecommerceapp/features/wishlist/domain/usecases/get_wishlist.dart';
import 'package:ecommerceapp/features/wishlist/domain/usecases/remove_from_wishlist.dart';
import 'package:ecommerceapp/features/wishlist/presentation/bloc/wishlist_cubit.dart';
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
  _initProduct();
  _initWishlist();
  _initCart();
  _initSplash();
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(serviceLocator()),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: serviceLocator(),
        sharedPreferences: serviceLocator(),
      ),
    )
    ..registerFactory(() => SignUp(serviceLocator()))
    ..registerFactory(() => UserLogin(serviceLocator()))
    ..registerFactory(() => SendOtp(serviceLocator()))
    ..registerFactory(() => VerifyOtp(serviceLocator()))
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
    ..registerFactory<CategoryRemoteDataSource>(
      () => CategoryRemoteDataSourceImpl(serviceLocator()),
    )
    ..registerFactory<CategoryRepository>(
      () => CategoryRepositoryImpl(serviceLocator()),
    )
    ..registerFactory(() => GetAllCategories(serviceLocator()))
    ..registerFactory(() => GetCategoryProducts(serviceLocator()))
    ..registerLazySingleton(
      () => CategoryCubit(getAllCategories: serviceLocator()),
    )
    ..registerFactory(
      () => CategoryProductsCubit(getCategoryProducts: serviceLocator()),
    );
}

void _initHome() {
  serviceLocator
    ..registerFactory<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(serviceLocator()),
    )
    ..registerFactory<HomeRepository>(
      () => HomeRepositoryImpl(serviceLocator()),
    )
    ..registerFactory(() => GetHomeData(serviceLocator()))
    ..registerFactory(() => HomeCubit(getHomeData: serviceLocator()));
}

void _initProduct() {
  serviceLocator
    // Data Source
    ..registerFactory<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(serviceLocator()),
    )
    // Repository
    ..registerFactory<ProductRepository>(
      () => ProductRepositoryImpl(serviceLocator()),
    )
    // Use Cases
    ..registerFactory(() => GetProductDetails(serviceLocator()))
    ..registerFactory(() => GetProductReviews(serviceLocator()))
    ..registerFactory(() => CreateReview(serviceLocator()))
    // Cubits
    ..registerFactory(() => ProductCubit(getProductDetails: serviceLocator()))
    ..registerFactory(
      () => ReviewCubit(
        getProductReviews: serviceLocator(),
        createReview: serviceLocator(),
      ),
    );
}

void _initWishlist() {
  serviceLocator
    // Data Source
    ..registerFactory<WishlistRemoteDataSource>(
      () => WishlistRemoteDataSourceImpl(serviceLocator()),
    )
    // Repository
    ..registerFactory<WishlistRepository>(
      () => WishlistRepositoryImpl(serviceLocator()),
    )
    // Use Cases
    ..registerFactory(() => GetWishlist(serviceLocator()))
    ..registerFactory(() => AddToWishlist(serviceLocator()))
    ..registerFactory(() => RemoveFromWishlist(serviceLocator()))
    // Cubit
    ..registerLazySingleton(
      () => WishlistCubit(
        getWishlist: serviceLocator(),
        addToWishlist: serviceLocator(),
        removeFromWishlist: serviceLocator(),
      ),
    );
}

void _initCart() {
  serviceLocator
    // Data Source
    ..registerFactory<CartRemoteDataSource>(
      () => CartRemoteDataSourceImpl(serviceLocator()),
    )
    // Repository
    ..registerFactory<CartRepository>(
      () => CartRepositoryImpl(serviceLocator()),
    )
    // Use Cases
    ..registerFactory(() => GetCartItems(serviceLocator()))
    ..registerFactory(() => AddToCart(serviceLocator()))
    ..registerFactory(() => UpdateCartQuantity(serviceLocator()))
    ..registerFactory(() => RemoveFromCart(serviceLocator()))
    // Cubit
    ..registerLazySingleton(
      () => CartCubit(
        getCartItems: serviceLocator(),
        addToCart: serviceLocator(),
        updateCartQuantity: serviceLocator(),
        removeFromCart: serviceLocator(),
      ),
    );
}

void _initSplash() {
  serviceLocator.registerFactory(
    () => SplashBloc(sharedPreferences: serviceLocator()),
  );
}
