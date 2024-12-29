import '/models/Books.dart';
import 'package:flutter/material.dart';

class BooksRead extends StatefulWidget {
  final List<Books> readBook;

  BooksRead(this.readBook);
  @override
  State<BooksRead> createState() => _BooksReadState();
}

class _BooksReadState extends State<BooksRead> {
  void _deleteBook(String id) {
    setState(() {
      widget.readBook.removeWhere((book) => book.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.readBook.length == 0
        ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Пока нет прочитанных книг',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24),
              ),
              FractionallySizedBox(
                widthFactor: 0.8,
                child: Image.asset(
                  'assets/img/book.png',
                ),
              ),
            ],
          )
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Text('Прочитанные книги', style: TextStyle(fontSize: 20)),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      child: ListTile(
                          title: Text(
                            widget.readBook[index].title,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                          subtitle: Text(
                            '${widget.readBook[index].genre}, ${widget.readBook[index].numOfPage} страниц',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () =>
                                      _deleteBook(widget.readBook[index].id),
                                  icon: Icon(Icons.delete)),
                            ],
                          )),
                    );
                  },
                  itemCount: widget.readBook.length,
                ),
              ),
            ],
          );
  }
}
