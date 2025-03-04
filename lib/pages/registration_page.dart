import '/models/user.dart';
import '/models/user_manager.dart';

import '/utils/validators.dart';

import '/widgets/auth_button.dart';
import '/widgets/input_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _onRegistration() {
    if (_formKey.currentState!.validate()) {
      final newUser = User(
          id: UniqueKey().toString(),
          name: _firstNameController.text,
          lastName: _lastNameController.text,
          email: _emailController.text,
          password: _passwordController.text);
          UserManager().setCurrentUser(newUser);
      print('Новый пользователь: $newUser');
      Navigator.pushNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Регистрация'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              InputAuth(
                label: 'Имя',
                hintText: 'Введите ваше имя',
                controller: _firstNameController,
                validate: Validators.validateName,
              ),
              const SizedBox(
                height: 20,
              ),
              InputAuth(
                label: 'Фамилия',
                hintText: 'Введите вашу фамилию',
                controller: _lastNameController,
                validate: Validators.validateName,
              ),
              const SizedBox(
                height: 20,
              ),
              InputAuth(
                label: 'Почта',
                hintText: 'Ваша почта',
                controller: _emailController,
                validate: Validators.validateEmail,
              ),
              const SizedBox(
                height: 20,
              ),
              InputAuth(
                label: 'Пароль',
                hintText: 'Придумайте пароль',
                controller: _passwordController,
                validate: Validators.validatePassword,
              ),
              const SizedBox(
                height: 20,
              ),
              AuthButton(
                  label: 'Зарегистрироваться', onPressed: _onRegistration)
            ],
          ),
        ),
      ),
    );
  }
}
