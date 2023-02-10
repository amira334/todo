import 'package:get/get.dart';
import '../dbprovider.dart';
import '../model/todo.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  var taskList = <ToDo>[].obs;

  Future<ToDo> addTask({ToDo? todo}) async {
    return await TodosDatabase.instance.create(todo!);
  }

  // get all the data from the table
  void getTasks() async {
    taskList.value = await TodosDatabase.instance.readAllTodos();
  }
}
