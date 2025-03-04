import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/widgets/books_read.dart';
import '/widgets/new_book.dart';
import '/widgets/book_list.dart';

import '/models/books.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
              behavior: HitTestBehavior.opaque,
              child: BooksRead(readBook),
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
  final List genre = [];

  bool switchVal = false;
  @override
  Widget build(BuildContext context) {
    final appBarIOS = CupertinoNavigationBar(
      middle: Text(
        'Учет книг',
        style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
            fontSize: 22),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      border: const Border(
        bottom: BorderSide(
          color: Colors.red,
          width: 1,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: Icon(
              CupertinoIcons.book_fill,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () => modalAddRead(context),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: Icon(
              CupertinoIcons.profile_circled,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) =>
                    ProfilePage(readBooks: readBook), 
              ),
            ),
          ),
        ],
      ),
    );

    final appBar = AppBar(
      title: const Text(
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
            icon: const Icon(Icons.auto_stories_outlined)),
        IconButton(
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(readBooks: readBook),
                  ),
                ),
            icon: const Icon(Icons.account_circle)),
      ],
    );
    final body = SafeArea(
      child: Column(children: [
        Expanded(
          child: BookList(
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
            navigationBar: appBarIOS,
            child: Stack(
              children: [
                body,
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: CupertinoButton(
                      color: Theme.of(context).colorScheme.primary,
                      child: const Icon(
                        CupertinoIcons.add,
                        color: Colors.white,
                      ),
                      onPressed: () => modalAddBook(context),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Scaffold(
            appBar: appBar,
            body: body,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterDocked,
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SafeArea(
                child: FloatingActionButton(
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  child: const Icon(
                    Icons.add,
                  ),
                  onPressed: () => modalAddBook(context),
                ),
              ),
            ),
          );
  }
}
