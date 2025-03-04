import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './pages/home_page.dart';
import './pages/auth_page.dart';
import '/pages/profile_page.dart';
import '/pages/registration_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  ThemeData darkTheme = ThemeData(
      colorScheme: ColorScheme.dark(
        primary: Color(0xFF74431D), // Основной цвет
        primaryContainer: Color(0xFF5C3214), // Темный оттенок основного цвета
        secondary: Color(0xFF3E2A20), // Темный акцентный цвет
        onPrimary: Color(0xFFFFFFFF), // Белый текст на основном цвете
        background: Color(0xFF1E1E1E), // Темный фон
        surface: Color(0xFF2A2A2A), // Карточки, кнопки — серый
        onBackground: Color(0xFFEDE3DB), // Светлый текст на фоне
        onSurface: Color(0xFFEDE3DB), // Светлый текст на элементах
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFF5C3214),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      fontFamily: 'Roboto',
      textTheme: ThemeData.light().textTheme.copyWith(
            bodyMedium: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            headlineMedium: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            titleLarge: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
            bodySmall: TextStyle(
              fontFamily: 'Italic',
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            labelLarge: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ));
  ThemeData lightTheme = ThemeData(
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF74431D), // Основной цвет
        primaryContainer: Color(0xFFD2A67A), // Светлый оттенок основного цвета
        secondary: Color(0xFFEDE3DB), // Нежный теплый оттенок для акцентов
        onPrimary: Color(0xFFFFFFFF), // Светлый фон
        surface: Color(0xFFFFFFFF), // Текст на фоне
        onSurface: Color(0xFF4A3A30), // Текст на элементах
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF74431D),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      fontFamily: 'Roboto',
      textTheme: ThemeData.light().textTheme.copyWith(
            bodyMedium: const TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            headlineMedium: const TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            titleLarge: const TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
            bodySmall: const TextStyle(
              fontFamily: 'Italic',
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            labelLarge: const TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ));

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Учет книг',
      home: const AuthPage(),
      routes: {
        '/home': (context) => HomePage(),
        '/registration': (context) => const RegistrationPage(),
        //'/profile': (context) => ProfilePage(),
      },
      debugShowCheckedModeBanner: false,
      theme: lightTheme, // Светлая тема
      darkTheme: darkTheme, // Темная тема
      themeMode: ThemeMode.light,
    );
  }
}
