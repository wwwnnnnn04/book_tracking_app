// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../models/Books.dart';

class Chart extends StatefulWidget {
  final List<Books> books;
  final Map<String, double> genre;

  Chart(this.books, this.genre);

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: widget.genre.entries.map((book) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                child: Text(
                  book.key,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onSurface),
                ),
              ),
              Container(
                width: 200,
                height: 10,
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.surface,
                  border: Border.all(
                      width: 1, color: Theme.of(context).colorScheme.onSurface),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: book.value,
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
