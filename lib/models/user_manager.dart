import './user.dart';
class UserManager {
  static final UserManager _instance = UserManager._internal();
  factory UserManager() => _instance;

  User? _currentUser;
  final List<User> _users = []; 

  UserManager._internal();

  User? get currentUser => _currentUser;

  void setCurrentUser(User user) {
    _currentUser = user;
  }

  void clearCurrentUser() {
    _currentUser = null;
  }

  void addUser(User user) {
    _users.add(user); 
  }

  User? findUserByEmailAndPassword(String email, String password) {
  try {
    return _users.firstWhere(
      (user) => user.email == email && user.password == password,
    );
  } catch (e) {
    return null; 
  }
}
}