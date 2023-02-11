import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/model/todo.dart';

class TaskTile extends StatelessWidget {
  final ToDo? task;
  final onEditItem;
  final onDeleteItem;
  const TaskTile({
    Key? key,
    required this.onEditItem,
    required this.onDeleteItem,
    this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 12),
      child: Slidable(
        key: ValueKey(task!.id),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => {
                onEditItem(task),
              },
              backgroundColor: const Color(0xFFbbdefb),
              foregroundColor: Colors.black,
              icon: Icons.edit,
              label: 'Edit',
              borderRadius: BorderRadius.circular(20),
            ),
            SlidableAction(
              onPressed: (context) => {
                onDeleteItem(task!.id),
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
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.blueGrey[900],
          ),
          child: Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task?.todoText ?? "",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey[200],
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "${task!.startTime} - ${task!.endTime}",
                        style: TextStyle(fontSize: 13, color: Colors.grey[100]),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 12),
                  // Text(
                  //   task?.note ?? "",
                  //   style: TextStyle(fontSize: 15, color: Colors.grey[100]),
                  // ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              width: 0.5,
              color: Colors.grey[200]!.withOpacity(0.7),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                task!.isDone == 1 ? "COMPLETED" : "TODO",
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
