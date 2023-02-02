import 'package:flutter/material.dart';
import '/main.dart';

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
      body: Card(
          elevation: 0,
          color: Colors.white,
          child: Text(
            'Todo app',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
    );
  }
}
