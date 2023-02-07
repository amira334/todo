import 'package:flutter/material.dart';

const String tableTodos = 'todos';

class ToDoFields {
  static final List<String> values = [
    id,
    todoText,
    isDone,
    note,
    date,
    startTime,
    endTime
  ];

  static const String id = '_id';
  static const String todoText = 'todoText';
  static const String isDone = 'isDone';

  static const String note = 'note';
  static const String date = 'date';
  static const String startTime = 'startTime';
  static const String endTime = 'endTime';
}

class ToDo {
  final int? id;
  final String todoText;
  final int isDone;
  final String note;
  final String date;
  final String startTime;
  final String endTime;

  const ToDo({
    this.id,
    required this.todoText,
    this.isDone = 0,
    required this.note,
    required this.date,
    required this.startTime,
    required this.endTime,
  });

  ToDo copy({
    int? id,
    String? todoText,
    int? isDone,
    String? note,
    String? date,
    String? startTime,
    String? endTime,
  }) =>
      ToDo(
        id: id ?? this.id,
        todoText: todoText ?? this.todoText,
        isDone: isDone ?? this.isDone,
        note: note ?? this.note,
        date: date ?? this.date,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
      );

  static ToDo fromJson(Map<String, Object?> json) => ToDo(
        id: json[ToDoFields.id] as int?,
        todoText: json[ToDoFields.todoText] as String,
        note: json[ToDoFields.note] as String,
        isDone: json[ToDoFields.isDone] as int,
        date: json[ToDoFields.date] as String,
        startTime: json[ToDoFields.startTime] as String,
        endTime: json[ToDoFields.endTime] as String,
      );

  Map<String, Object?> toJson() => {
        ToDoFields.id: id,
        ToDoFields.todoText: todoText,
        ToDoFields.isDone: isDone,
        ToDoFields.note: note,
        ToDoFields.date: date,
        ToDoFields.startTime: startTime,
        ToDoFields.endTime: endTime,
      };
}
