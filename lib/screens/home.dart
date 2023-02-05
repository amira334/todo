import 'package:flutter/material.dart';
import '../model/todo.dart';
import '../widgets/search.dart';
import '../widgets/todo_item.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                  Container(
                    // margin: const EdgeInsets.symmetric(
                    //   vertical: 10,
                    // ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(DateFormat.yMMMMd().format(DateTime.now()),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                  child: Search()),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: todoList
                        .map(
                          (todo) => ToDoItem(
                        todo: todo,
                        onToDoChanged: _handleToDoChange,
                        onDeleteItem: _handleDeleteItem,
                      ),
                    )
                        .toList(),
                  ),
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                      left: 20,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 0.0,
                          blurRadius: 10,
                          offset: const Offset(0.0, 0.0),
                        )
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Add ToDo',
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      _addTodoItem(_todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(60, 60),
                      elevation: 10,
                    ),
                    child: const Text(
                      '+',
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
