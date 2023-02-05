import 'package:flutter/material.dart';
import '../model/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;
  const ToDoItem(
      {Key? key,
      required this.todo,
      required this.onToDoChanged,
      required this.onDeleteItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.id!),
      background: Container(
        padding: EdgeInsets.only(left: 20),
        margin: EdgeInsets.symmetric(vertical: 5),
        alignment: Alignment.centerLeft,
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
      secondaryBackground: Container(
        padding: const EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(vertical: 5),
        alignment: Alignment.centerRight,
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      onDismissed: (direction) {
        onDeleteItem(todo);
      },
      child: Card(
        elevation: 0,
        child: ListTile(
          onTap: () {
            onToDoChanged(todo);
          },
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          leading: Icon(
            todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: Theme.of(context).colorScheme.secondary,
          ),
          title: Text(
            todo.todoText!,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              decoration: todo.isDone ? TextDecoration.lineThrough : null,
            ),
          ),
        ),
      ),
    );
  }
}
