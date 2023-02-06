import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/input_field.dart';
import 'package:intl/intl.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .primary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .primary,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back,
            color: Theme
                .of(context)
                .colorScheme
                .tertiary,
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

              Text('Add Task',
                style: Theme
                    .of(context)
                    .textTheme
                    .headline6,),
              const InputField(
                title: 'Title',
                hint: 'Title',
              ),
              const InputField(
                title: 'Description',
                hint: 'Description',
              ),
              InputField(
                title: 'Date',
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: Icon(Icons.calendar_month_outlined),
                  onPressed: () {
                    _getDate();
                  },
                  color: Theme
                      .of(context)
                      .colorScheme
                      .tertiary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getDate() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2030),

    );
  }

}
