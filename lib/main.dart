// ignore_for_file: deprecated_member_use, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/widgets/chart.dart';
import '/widgets/books_read.dart';
import '/widgets/new_book.dart';
import '/widgets/book_list.dart';

import '/models/Books.dart';

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
      colorScheme: ColorScheme.light(
        primary: Color(0xFF74431D), // Основной цвет
        primaryContainer: Color(0xFFD2A67A), // Светлый оттенок основного цвета
        secondary: Color(0xFFEDE3DB), // Нежный теплый оттенок для акцентов
        onPrimary: Color(0xFFFFFFFF), // Белый текст на основном цвете
        background: Color(0xFFF9F5F2), // Светлый фон
        surface: Color(0xFFFFFFFF), // Карточки, кнопки — чисто белый
        onBackground: Color(0xFF4A3A30), // Текст на фоне
        onSurface: Color(0xFF4A3A30), // Текст на элементах
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFF74431D),
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

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Учет книг',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      theme: lightTheme, // Светлая тема
      darkTheme: darkTheme, // Темная тема
      themeMode: ThemeMode.light,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void modalAddBook(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewBook(_addNewBook),
          );
        });
  }

  void modalAddRead(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return FractionallySizedBox(
            heightFactor: 0.8,
            widthFactor: 1.0,
            child: GestureDetector(
              onTap: () {},
              child: BooksRead(readBook),
              behavior: HitTestBehavior.opaque,
            ),
          );
        });
  }

  Map<String, double> genrePercentages = {};
  void _addNewBook(String title, String genre, int numOfPage) {
    final newBook = Books(
        title: title,
        genre: genre,
        numOfPage: numOfPage,
        id: DateTime.now().toString());

    setState(() {
      books.add(newBook);
      genrePercentages = _genrePrc(books);
    });
  }

  void _deleteBook(String id) {
    setState(() {
      books.removeWhere((book) => book.id == id);
      genrePercentages = _genrePrc(books);
    });
  }

  Map<String, int> _createMap(List<Books> books) {
    Map<String, int> genreCount = {};
    for (var book in books) {
      genreCount[book.genre] = (genreCount[book.genre] ?? 0) + 1;
    }
    return genreCount;
  }

  Map<String, double> _genrePrc(List<Books> books) {
    final totalBooks = books.length;
    if (totalBooks == 0) return {};
    final genreCount = _createMap(books);
    return genreCount.map((genre, count) {
      double precent = count / totalBooks;
      return MapEntry(genre, precent);
    });
  }

  final List<Books> books = [];

  final List<Books> readBook = [];
  final List genre = [
    'Триллер',
    'Детектив',
    'Роман',
    'Классика',
    'Комедия',
    'Хоррор'
  ];

  bool switchVal = false;
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final higthPlatform = media.size.height;

    final topLine = media.padding.top;
    final bottomView = media.viewInsets.bottom;
    final orient = media.orientation == Orientation.landscape;

    final appBarIOS = CupertinoNavigationBar(
      middle: Text(
        'Учет книг',
        style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            fontSize: 22),
      ),
      trailing: Row(
        children: [
          GestureDetector(
            child: Icon(CupertinoIcons.book_fill),
            onTap: () => modalAddRead(context),
          )
        ],
      ),
    );

    final appBar = AppBar(
      title: Text(
        'Учет книг',
        style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            fontSize: 22),
      ),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () => modalAddRead(context),
            icon: Icon(Icons.auto_stories_outlined))
      ],
    );
    final body = SafeArea(
      child: Column(children: [
        Expanded(
          child: Book_List(
            books,
            _deleteBook,
            readBook,
            genrePercentages,
          ),
        ),
      ]),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: body,
            navigationBar: appBarIOS,
          )
        : Scaffold(
            appBar: appBar,
            body: body,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterDocked,
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                child: Icon(
                  Icons.add,
                ),
                onPressed: () => modalAddBook(context),
              ),
            ),
          );
  }
}
