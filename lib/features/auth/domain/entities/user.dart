// User entity — id, name, email, phone, avatar.
class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final bool emailVerified;
  final String phone;
  final bool phoneVerified;
  final String? avatarUrl;
  final String city;
  final int role;
  final String? token;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.emailVerified,
    required this.phone,
    required this.phoneVerified,
    this.avatarUrl,
    required this.city,
    required this.role,
    this.token,
  });
}
