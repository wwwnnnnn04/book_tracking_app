import 'package:flutter/material.dart';

class NewBook extends StatefulWidget {
  final Function(String, String, int) addNewBook;

  NewBook(this.addNewBook);
  @override
  State<NewBook> createState() => _NewBookState();
}

class _NewBookState extends State<NewBook> {
  final titleCnt = TextEditingController();
  final genreCnt = TextEditingController();
  final numOfPageCnt = TextEditingController();

  void _submitData() {
    if (titleCnt.text.isEmpty ||
        genreCnt.text.isEmpty ||
        numOfPageCnt.text.isEmpty) {
      return;
    }
    widget.addNewBook(
        titleCnt.text, genreCnt.text, int.parse(numOfPageCnt.text));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final bottomView = media.viewInsets.bottom;
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
              top: 15, left: 15, right: 15, bottom: bottomView + 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Название книги'),
                controller: titleCnt,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Жанр'),
                controller: genreCnt,
              ),
              TextField(
                decoration:
                    const InputDecoration(labelText: 'Количество страниц'),
                keyboardType: TextInputType.number,
                controller: numOfPageCnt,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: ElevatedButton(
                  onPressed: _submitData,
                  child: const Text('Добавить'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
