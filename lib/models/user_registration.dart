class UserRegistration {
  int? id;
  final String username;
  final String email;
  final String password;

  UserRegistration(
      {this.id,
      required this.username,
      required this.email,
      required this.password});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password
    };
  }

  factory UserRegistration.fromJson(Map<String, dynamic> json) {
    return UserRegistration(
        id: json['id'] as int?,
        username: json['username'] as String,
        email: json['email'] as String,
        password: json['password'] as String);
  }
}
