import 'package:flutter/material.dart';
import '../model/todo.dart';
import '../widgets/search.dart';
import '../widgets/todo_item.dart';
import 'package:intl/intl.dart';
import '../widgets/button.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  final todoList = ToDo.todoList();
  final _todoController = TextEditingController();

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
      // floatingActionButton: const FloatingActionButton(
      //   onPressed: null,
      //   child: Icon(Icons.add),
      // ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Stack(children: [
          Column(
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat.yMMMMd().format(DateTime.now()),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  )
                ],
              ),
              Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: Search()
              ),
              Column(
                children: [
                  Text()
                ],
              )

              // Expanded(
              //   child: SingleChildScrollView(
              //     child: Column(
              //       children: todoList
              //           .map(
              //             (todo) => ToDoItem(
              //           todo: todo,
              //           onToDoChanged: _handleToDoChange,
              //           onDeleteItem: _handleDeleteItem,
              //         ),
              //       )
              //           .toList(),
              //     ),
              //   ),
              // ),

            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Button(label: '+ Add Task', onTap: ()=> null)),
            )
        ]),
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _handleDeleteItem(ToDo todo) {
    setState(() {
      todoList.remove(todo);
    });
  }

  void _addTodoItem(String toDo) {
    setState(() {
      todoList.add(ToDo(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        todoText: toDo,
      ));
    });
    _todoController.clear();
  }
}
