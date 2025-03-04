class User {
  final String id;
  final String name;
  final String lastName;
  final String email;
  final String password;

  User({
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
    required this.password,
  });

  @override
  String toString(){
    return 'User(name: $name, lastName: $lastName, email: $email, password: $password)';
  }
}
