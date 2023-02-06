const String tableTodos = 'todos';

class ToDoFields {
  static final List<String> values = [id, todoText, isDone];

  static const String id = '_id';
  static const String todoText = 'todoText';
  static const String isDone = 'isDone';
}

class ToDo {
  final int? id;
  final String todoText;
  final int isDone;

  const ToDo({
    this.id,
    required this.todoText,
    this.isDone = 0,
  });

  ToDo copy({
    int? id,
    String? todoText,
    int? isDone,
  }) =>
      ToDo(
        id: id ?? this.id,
        todoText: todoText ?? this.todoText,
        isDone: isDone ?? this.isDone,
      );

  static ToDo fromJson(Map<String, Object?> json) => ToDo(
        id: json[ToDoFields.id] as int?,
        todoText: json[ToDoFields.todoText] as String,
        isDone: json[ToDoFields.isDone] as int,
      );

  Map<String, Object?> toJson() => {
        ToDoFields.id: id,
        ToDoFields.todoText: todoText,
        ToDoFields.isDone: isDone,
      };

  static List<ToDo> todoList() {
    return [
      const ToDo(id: 1, todoText: 'Buy Milk', isDone: 1),
      const ToDo(id: 2, todoText: 'Buy Bread', isDone: 1),
      const ToDo(id: 3, todoText: 'Buy Eggs'),
      const ToDo(id: 4, todoText: 'Buy Butter'),
      const ToDo(id: 5, todoText: 'Buy Cheese'),
      const ToDo(id: 6, todoText: 'Buy Chicken'),
    ];
  }
}
