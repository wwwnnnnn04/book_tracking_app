import '/widgets/chart.dart';
import 'package:flutter/material.dart';

import '../models/books.dart';

class BookList extends StatefulWidget {
  final List<Books> books;
  final Function(String) deleteBook;
  final List<Books> readBook;
  final Map<String, double> genre;

  BookList(this.books, this.deleteBook, this.readBook, this.genre);

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  void _addReadBook(Books book) {
    for (int i = 0; i < widget.readBook.length; i++) {
      if (widget.readBook[i].id == book.id) {
        return;
      }
    }
    setState(() {
      widget.readBook.add(book);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.books.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Пока нет книг',
                        style: TextStyle(
                          fontSize: 24,
                          color: Theme.of(context).colorScheme.primary,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: constraints.maxHeight * 0.5,
                    child: Image.asset(
                      'assets/img/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            );
          })
        : Column(
            children: [
              Flexible(flex: 1, child: Chart(widget.books, widget.genre)),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      child: ListTile(
                          title: Text(
                            widget.books[index].title,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                          subtitle: Text(
                            '${widget.books[index].genre}, ${widget.books[index].numOfPage} страниц',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () =>
                                      _addReadBook(widget.books[index]),
                                  icon: const Icon(Icons.auto_stories_rounded)),
                              IconButton(
                                  onPressed: () =>
                                      widget.deleteBook(widget.books[index].id),
                                  icon: const Icon(Icons.delete)),
                            ],
                          )),
                    );
                  },
                  itemCount: widget.books.length,
                ),
              ),
            ],
          );
  }
}
