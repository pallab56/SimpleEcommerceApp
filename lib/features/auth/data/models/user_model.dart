// UserModel — JSON-serializable DTO extending the User entity.
import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.emailVerified,
    required super.phone,
    required super.phoneVerified,
    super.avatarUrl,
    required super.city,
    required super.role,
    super.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> map, {String? token}) {
    return UserModel(
      id: map['_id'] ?? '',
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      email: map['email'] ?? '',
      emailVerified: map['email_verified'] ?? false,
      phone: map['phone'] ?? '',
      phoneVerified: map['phone_verified'] ?? false,
      avatarUrl: map['avatar_url'],
      city: map['city'] ?? '',
      role: map['role'] ?? 0,
      token: token ?? map['token'],
    );
  }

  /// Parses API responses shaped as: { "data": { "token": "...", "user": { ... } } }
  factory UserModel.fromAuthData(Map<String, dynamic> data) {
    return UserModel.fromJson(
      data['user'] as Map<String, dynamic>,
      token: data['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'email_verified': emailVerified,
      'phone': phone,
      'phone_verified': phoneVerified,
      'avatar_url': avatarUrl,
      'city': city,
      'role': role,
      if (token != null) 'token': token,
    };
  }
}
