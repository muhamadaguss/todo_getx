import 'package:get/get.dart';
import 'package:todo/db/db_helper.dart';
import 'package:todo/models/task.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    getTasks();
    super.onReady();
  }

  // @override
  // void onInit() {
  //   // getTasks();
  //   super.onInit();
  // }

  var taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) async {
    return await DBHelper.insert(task);
  }

  //get all the data from table
  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((e) => Task.fromJson(e)).toList());
  }

  //delete data
  void delete(Task task) {
    DBHelper.delete(task);
  }

  //update completed
  void markTaskCompleted(int id) async {
    await DBHelper.update(id);
  }
}
