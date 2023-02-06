import 'package:flutter/material.dart';
import 'package:todo/dbprovider.dart';
import '../model/todo.dart';
import '../widgets/search.dart';
import '../widgets/todo_item.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  late List<ToDo> todos;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshToDos();
  }

  @override
  void dispose() {
    TodosDatabase.instance.close();
    super.dispose();
  }

  Future refreshToDos() async {
    setState(() => isLoading = true);
    todos = await TodosDatabase.instance.readAllTodos();
    setState(() => isLoading = false);
  }

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
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  )
                ],
              ),
              Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: Search()),
              Row(
                children: [
                  Text(
                    'My Task',
                    style: Theme.of(context).textTheme.headline6,
                  )
                ],
              ),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : todos.isEmpty
                      ? const Center(child: Text('No tasks'))
                      : Expanded(
                          child: ListView.builder(
                            itemCount: todos.length,
                            itemBuilder: (context, index) {
                              return ToDoItem(
                                todo: todos[index],
                                onToDoChanged: _handleToDoChange,
                                onDeleteItem: _handleDeleteItem,
                              );
                            },
                          ),
                        )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: _addTodoItem,
                  child: const Text('add'),
                )),
          )
        ]),
      ),
    );
  }

  void _handleToDoChange(ToDo todo) async {
    final obj = todo.copy(
      isDone: todo.isDone == 0 ? 1 : 0,
    );
    await TodosDatabase.instance.update(obj);
    refreshToDos();
  }

  void _handleDeleteItem(todoId) async {
    await TodosDatabase.instance.delete(todoId);
    refreshToDos();
  }

  void _addTodoItem() async {
    const todo = ToDo(
      todoText: 'Test task',
    );

    await TodosDatabase.instance.create(todo);
    refreshToDos();
  }
}
