import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:todo/dbprovider.dart';
import 'package:todo/screens/edit_task_screen.dart';
import '../controllers/task_controller.dart';
import '../model/todo.dart';
import '../widgets/search.dart';
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
  RxList<ToDo> filteredTasks = <ToDo>[].obs;
  bool showSearchWidget = false;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    filteredTasks.value = _taskController.taskList;
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
                        selectedDate != null
                            ? DateFormat.yMd().format(selectedDate!) ==
                                    DateFormat.yMd().format(DateTime.now())
                                ? 'Today'
                                : 'Showing tasks for'
                            : 'All',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      if (selectedDate != null)
                        Text(
                          DateFormat.yMMMMd().format(selectedDate!),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                    ],
                  ),
                  IconButton(
                    onPressed: handleSearch,
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 24,
                    ),
                  )
                ],
              ),
              if (showSearchWidget == true)
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: Search(
                    runFilter: runFilter,
                  ),
                ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: DatePicker(
                  dateTextStyle: const TextStyle(
                    fontSize: 20,
                    color: Color(0xFF5d8e8a),
                  ),
                  DateTime.now(),
                  height: 90,
                  width: 70,
                  selectionColor: Theme.of(context).colorScheme.secondary,
                  selectedTextColor: Colors.black,
                  onDateChange: (date) {
                    setState(() {
                      selectedDate = date;
                    });
                    dateFilter(DateFormat.yMd().format(date));
                  },
                ),
              ),
              // Container(
              //   margin: const EdgeInsets.only(bottom: 10),
              //   child: Row(
              //     children: [
              //       Text(
              //         'My Task',
              //         style: Theme.of(context).textTheme.titleLarge,
              //       )
              //     ],
              //   ),
              // ),
              Expanded(
                child: Obx(
                  () {
                    if (filteredTasks.isEmpty) {
                      return Column(
                        children: [
                          Text(
                            'No task found!',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 30,
                            ),
                            child: SizedBox(
                              height: 200,
                              child: Image.asset(
                                'assets/images/task.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return ListView.builder(
                      itemCount: filteredTasks.length,
                      itemBuilder: (_, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          child: SlideAnimation(
                            child: FadeInAnimation(
                              child: ToDoItem(
                                todo: filteredTasks[index],
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
              vertical: 18,
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

  void runFilter(String enteredKeyword) {
    RxList<ToDo> results = <ToDo>[].obs;
    if (enteredKeyword.isEmpty) {
      results.value = _taskController.taskList;
    } else {
      results.value = _taskController.taskList
          .where((task) => task.todoText
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      filteredTasks.value = results;
    });
  }

  void dateFilter(String date) {
    RxList<ToDo> results = <ToDo>[].obs;
    results.value =
        _taskController.taskList.where((task) => task.date == date).toList();

    setState(() {
      filteredTasks.value = results;
    });
  }

  void handleSearch() {
    setState(() {
      showSearchWidget = !showSearchWidget;
    });
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
