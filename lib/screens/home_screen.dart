import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:todo/dbprovider.dart';
import 'package:todo/screens/edit_task_screen.dart';
import '../controllers/task_controller.dart';
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
  final _taskController = Get.put(TaskController());
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _taskController.getTasks();
  }

  @override
  void dispose() {
    TodosDatabase.instance.close();
    super.dispose();
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
              Expanded(
                child: Obx(
                  () {
                    return ListView.builder(
                      itemCount: _taskController.taskList.length,
                      itemBuilder: (_, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          child: SlideAnimation(
                            child: FadeInAnimation(
                              child: ToDoItem(
                                todo: _taskController.taskList[index],
                                onToDoChanged: _handleToDoChange,
                                onDeleteItem: _handleDeleteItem,
                                onEditItem: _handleEditItem,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Button(
                label: '+ Add Task',
                onTap: () async {
                  await Get.to(const AddTaskScreen());
                  _taskController.getTasks();
                },
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
      results = _taskController.taskList;
    } else {
      results = _taskController.taskList
          .where(
            (element) => element.todoText
                .toLowerCase()
                .contains(enteredText.toLowerCase()),
          )
          .toList();
    }

    // setState(() {
    //   _foundTodos = results;
    // });
  }

  void _handleToDoChange(ToDo todo) async {
    final obj = todo.copy(
      isDone: todo.isDone == 0 ? 1 : 0,
    );
    await TodosDatabase.instance.update(obj);
    _taskController.getTasks();
  }

  void _handleEditItem(ToDo todo) async {
    await Get.to(EditTaskScreen(todo: todo));
    _taskController.getTasks();
  }

  void _handleDeleteItem(todoId) async {
    await TodosDatabase.instance.delete(todoId);
    _taskController.getTasks();
  }
}
