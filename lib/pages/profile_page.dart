import 'package:flutter/material.dart';

import '/models/books.dart';
import '/models/user_manager.dart';

import '/widgets/books_read.dart';

class ProfilePage extends StatelessWidget {
  final List<Books> readBooks;

  ProfilePage({required this.readBooks});

  @override
  Widget build(BuildContext context) {
    final user = UserManager().currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('Пользователь не авторизован')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Имя: ${user.name}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Фамилия: ${user.lastName}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Email: ${user.email}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            BooksRead(readBooks),
          ],
        ),
      ),
    );
  }
}
