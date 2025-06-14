class User {
  final String username;
  final String password;
  final bool isAdmin;

  User({required this.username, required this.password, this.isAdmin = false});

  Map<String, dynamic> toMap() {
    return {'username': username, 'password': password, 'isAdmin': isAdmin};
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'],
      password: map['password'],
      isAdmin: map['isAdmin'] ?? false,
    );
  }
}
