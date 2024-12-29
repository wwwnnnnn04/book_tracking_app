// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Название книги'),
            controller: titleCnt,
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Жанр'),
            controller: genreCnt,
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Количество страниц'),
            keyboardType: TextInputType.number,
            controller: numOfPageCnt,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: ElevatedButton(
              onPressed: _submitData,
              child: Text('Добавить'),
            ),
          )
        ],
      ),
    );
  }
}
