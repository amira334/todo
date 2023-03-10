import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../model/todo.dart';
import '../screens/edit_task_screen.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;
  final onEditItem;
  const ToDoItem(
      {Key? key,
      required this.todo,
      required this.onToDoChanged,
      required this.onDeleteItem,
      required this.onEditItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Slidable(
        key: ValueKey(todo.id!),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => {
                onEditItem(todo),
              },
              backgroundColor: const Color(0xFFbbdefb),
              foregroundColor: Colors.black,
              icon: Icons.edit,
              label: 'Edit',
              borderRadius: BorderRadius.circular(20),
            ),
            SlidableAction(
              onPressed: (context) => {
                onDeleteItem(todo.id),
              },
              backgroundColor: const Color(0xFFffcdd2),
              foregroundColor: Colors.black,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: BorderRadius.circular(20),
            ),
          ],
        ),
        child: Container(

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color(0xFFF3F3F3),
                spreadRadius: 3,
                blurRadius: 3,
                offset: Offset(-2, 3),
              ),
            ],
          ),
          child: ListTile(
            onTap: () {
              onToDoChanged(todo);
            },
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: Icon(
              todo.isDone == 1
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              color: Theme.of(context).colorScheme.secondary,
            ),
            title: Column(
              children: [
                Text(
                  //textAlign: TextAlign.start,
                  todo.todoText,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    decoration:
                        todo.isDone == 1 ? TextDecoration.lineThrough : null,
                  ),
                ),
                // Row(
                //   children: [
                //     Text(
                //         todo.startTime
                //     ),
                //     Text(
                //       todo.endTime
                //     )
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
