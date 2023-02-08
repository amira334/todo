import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo/dbprovider.dart';
import '../model/todo.dart';

//import '../widgets/search.dart';
import '../widgets/todo_item.dart';
import 'package:intl/intl.dart';
import '../widgets/button.dart';
import 'add_task_screen.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  late List<ToDo> todos;
  bool isLoading = false;
  List<ToDo> _foundTodos = [];

  @override
  void initState() {
    super.initState();
    refreshToDos();
    //_foundTodos = todos;
  }

  @override
  void dispose() {
    TodosDatabase.instance.close();
    super.dispose();
  }

  Future refreshToDos() async {
    setState(() => isLoading = true);
    todos = await TodosDatabase.instance.readAllTodos();
    _foundTodos = todos;
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        title: const Text('ToDo'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Stack(children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat.yMMMMd().format(DateTime.now()),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        'Today',
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  ),
                  IconButton(
                    onPressed: () => {},
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 24,
                    ),
                  )
                ],
              ),
              // Container(
              //   margin: const EdgeInsets.symmetric(
              //     vertical: 10,
              //   ),
              //   child: Search(
              //     runFilter: runFilter,
              //   ),
              // ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: DatePicker(
                  DateTime.now(),
                  height: 100,
                  width: 80,
                  initialSelectedDate: DateTime.now(),
                  selectionColor: Theme.of(context).colorScheme.secondary,
                  selectedTextColor: Colors.black,
                ),
              ),
              Row(
                children: [
                  Text(
                    'My Task',
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                ],
              ),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : todos.isEmpty
                      //? const Center(child: Text('No tasks'))
                      ? Column(
                          children: [
                            Text(
                              'No task added yet!',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                            // const SizedBox(
                            //   height: 30,
                            // ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 20,
                              ),
                              child: Center(
                                child: SizedBox(
                                  height: 200,
                                  //height: constraints.maxHeight * 0.5,
                                  child: Image.asset(
                                    'assets/images/task.png',
                                    fit: BoxFit.cover,
                                    // alignment: Alignment.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: _foundTodos.length,
                            itemBuilder: (context, index) {
                              return ToDoItem(
                                todo: _foundTodos[index],
                                onToDoChanged: _handleToDoChange,
                                onDeleteItem: _handleDeleteItem,
                              );
                            },
                          ),
                        )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 18,
            ),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Button(
                label: '+ Add Task',
                onTap: () => Get.to(const AddTaskScreen()),
              ),
            ),
          )
        ]),
      ),
    );
  }

  void runFilter(String enteredText) {
    List<ToDo> results = [];
    if (enteredText.isEmpty) {
      results = todos;
    } else {
      results = todos
          .where(
            (element) => element.todoText
                .toLowerCase()
                .contains(enteredText.toLowerCase()),
          )
          .toList();
    }

    setState(() {
      _foundTodos = results;
    });
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
}
