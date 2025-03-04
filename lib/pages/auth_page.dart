import 'package:accounting_of_books/utils/validators.dart';
import 'package:flutter/material.dart';

import '../widgets/auth_button.dart';

import '/models/user_manager.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void onPressed() {
    if (_formKey.currentState!.validate()) {
      final user = UserManager().currentUser;
      if (user == null ||
          user.email != _emailController.text ||
          user.password != _passwordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Пользователь не найден'),
            duration: Durations.medium3,
          ),
        );
      } else {
        UserManager().setCurrentUser(user);
        Navigator.pushNamed(context, '/home');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Авторизация'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                'Вход',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Почта',
                  hintText: 'Введите ваш email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: Validators.validateEmail,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Пароль',
                  hintText: 'Введите ваш пароль',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: Validators.validatePassword,
              ),
              const SizedBox(height: 20),
              AuthButton(label: 'Войти', onPressed: onPressed),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/registration'),
                child: const Text('Еще нет аккаунта?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
