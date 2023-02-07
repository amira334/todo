import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../dbprovider.dart';
import '../model/todo.dart';
import '../widgets/input_field.dart';
import 'package:intl/intl.dart';
import '../widgets/button.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  // add 10 minutes to the current time
  String _endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 10)))
      .toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Task',
                style: Theme.of(context).textTheme.headline6,
              ),
              InputField(
                title: 'Title',
                hint: 'Type here....',
                controller: _titleController,
              ),
              InputField(
                title: 'Date',
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: Icon(Icons.calendar_month_outlined),
                  onPressed: () {
                    _getDate();
                  },
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: InputField(
                          title: 'Start Time',
                          hint: _startTime,
                          widget: IconButton(
                            onPressed: () {
                              _getTime(isStartTime: true);
                            },
                            icon: Icon(Icons.timer_outlined),
                            color: Color(0xFF5d8e8a),
                          ))),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                      child: InputField(
                          title: 'End Time',
                          hint: _endTime,
                          widget: IconButton(
                            onPressed: () {
                              _getTime(isStartTime: false);
                            },
                            icon: Icon(Icons.timer_outlined),
                            color: Color(0xFF5d8e8a),
                          ))),
                ],
              ),
              Container(
                height: 100,
                child: InputField(
                    title: 'Description',
                    hint: 'Type here....',
                    controller: _noteController),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Button(
                        label: 'Create Task',
                        onTap: () => _validatedData(),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _validatedData() async {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      ToDo todo = ToDo(
        todoText: _titleController.text,
        note: _noteController.text,
        date: _selectedDate.toString(),
        startTime: _startTime,
        endTime: _endTime,
      );

      await TodosDatabase.instance.create(todo);

      Get.back();
      Get.snackbar('Success', 'Task created successfully',
          snackPosition: SnackPosition.TOP,
          icon: const Icon(Icons.check_circle_outline),
          backgroundColor: const Color(0xffC3F8E3),
          colorText: Colors.black);
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar('Required', 'All fields are required',
          snackPosition: SnackPosition.TOP,
          icon: const Icon(Icons.warning_amber_outlined),
          backgroundColor: const Color(0xffF8BEC3),
          colorText: Colors.black);
    }
  }

  _getDate() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2030),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData(
              primarySwatch: Colors.blueGrey,
              splashColor: Colors.black,
              textTheme: const TextTheme(
                titleMedium: TextStyle(color: Colors.black),
                labelLarge: TextStyle(color: Colors.black),
              ),
              colorScheme: const ColorScheme.light(
                  primary: Color(0xff649893),
                  onSecondary: Colors.black,
                  onPrimary: Colors.white,
                  surface: Colors.black,
                  onSurface: Colors.black87,
                  secondary: Colors.black),
              dialogBackgroundColor: Colors.white,
            ),
            child: child ?? Text(""),
          );
        });
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {
      return;
    }
  }

  _getTime({required bool isStartTime}) async {
    _showTimePicker();
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
      return;
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        context: context,
        initialTime: TimeOfDay(
          hour: int.parse(_startTime.split(':')[0]),
          minute: int.parse(_startTime.split(':')[1].split(' ')[0]),
        ),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData(
              primarySwatch: Colors.blueGrey,
              splashColor: Colors.black,
              textTheme: const TextTheme(
                subtitle1: TextStyle(color: Colors.black),
                button: TextStyle(color: Colors.black),
              ),
              colorScheme: const ColorScheme.light(
                  primary: Color(0xff649893),
                  onSecondary: Colors.black,
                  onPrimary: Colors.white,
                  surface: Colors.white,
                  onSurface: Colors.black,
                  secondary: Colors.black),
              dialogBackgroundColor: Colors.white,
            ),
            child: child ?? Text(""),
          );
        });
  }
}
