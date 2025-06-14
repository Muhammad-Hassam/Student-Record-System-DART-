import 'dart:io';
import '../models/user.dart';
import '../utils/console_utils.dart';

class AuthService {
  final Map<String, User> _users = {
    'admin': User(username: 'admin', password: 'admin123', isAdmin: true),
  };

  User? _currentUser;

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;
  bool get isAdmin => _currentUser?.isAdmin ?? false;

  void signUp() {
    print('\nSign Up');
    print('-' * 20);

    final username = ConsoleUtils.readString('Enter username: ');
    if (_users.containsKey(username)) {
      print('Username already exists!');
      return;
    }

    final password = ConsoleUtils.readString('Enter password: ');
    final confirmPassword = ConsoleUtils.readString('Confirm password: ');

    if (password != confirmPassword) {
      print('Passwords do not match!');
      return;
    }

    _users[username] = User(username: username, password: password);
    print('Account created successfully! You can now login.');
  }

  bool login() {
    print('\nLogin');
    print('-' * 20);

    final username = ConsoleUtils.readString('Enter username: ');
    final password = ConsoleUtils.readString('Enter password: ');

    final user = _users[username];
    if (user == null || user.password != password) {
      print('Invalid username or password!');
      return false;
    }

    _currentUser = user;
    print('Login successful! Welcome, ${user.username}');
    return true;
  }

  void logout() {
    _currentUser = null;
    print('Logged out successfully.');
  }
}
