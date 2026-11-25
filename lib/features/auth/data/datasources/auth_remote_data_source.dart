import '../../../../core/constants/api_urls.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phone,
    required String city,
  });

  Future<UserModel> login({
    required String email,
    required String password,
  });

  Future<String> sendOtp({required String email});

  Future<UserModel> verifyOtp({
    required String email,
    required String otp,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  const AuthRemoteDataSourceImpl(this.apiClient);

  @override
  Future<String> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phone,
    required String city,
  }) async {
    try {
      final response = await apiClient.post(
        ApiUrls.signUp,
        body: {
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'password': password,
          'phone': phone,
          'city': city,
        },
      );

      if (response['status'] == 'success') {
        return response['msg'] ?? 'Account created. Please verify your email.';
      } else {
        throw ServerException(message: response['msg'] ?? 'Sign up failed');
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await apiClient.post(
        ApiUrls.login,
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response['status'] == 'success' && response['data'] != null) {
        return UserModel.fromAuthData(response['data'] as Map<String, dynamic>);
      } else {
        throw ServerException(message: response['msg'] ?? 'Login failed');
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> sendOtp({required String email}) async {
    try {
      final response = await apiClient.post(
        ApiUrls.sendOtp,
        body: {'email': email},
      );

      if (response['status'] == 'success') {
        return response['msg'] ?? 'OTP sent to your email address.';
      } else {
        throw ServerException(message: response['msg'] ?? 'Failed to send OTP');
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await apiClient.post(
        ApiUrls.verifyOtp,
        body: {
          'email': email,
          'otp': otp,
        },
      );

      if (response['status'] == 'success' && response['data'] != null) {
        return UserModel.fromAuthData(response['data'] as Map<String, dynamic>);
      } else {
        throw ServerException(
          message: response['msg'] ?? 'OTP verification failed',
        );
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
