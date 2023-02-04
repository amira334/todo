import 'package:flutter/material.dart';
import '/main.dart';
import './search.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        //backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('ToDo'),
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
            child: Search()
      ),
    );
  }
}