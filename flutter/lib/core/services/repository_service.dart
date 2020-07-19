import 'package:gorev_yoneticisi/core/models/add_new_task.dart';
import 'package:gorev_yoneticisi/core/models/common_response.dart';

import '../models/category_list.dart';
import '../models/task.dart';
import 'mongodb_service.dart';

//this class gets and returns data between mongo service and view model classes
class RepositoryService {
  static RepositoryService _instance;
  static RepositoryService get instance {
    if (_instance == null) _instance = RepositoryService._init();
    return _instance;
  }

  MongoDbService _mongoDbService = MongoDbService.instance;

  RepositoryService._init();

  //get all categories from db
  Future<List<CategoryList>> getAllCategories() async {
    return await _mongoDbService.getAllCategories();
  }

  //get task by id
  Future<List<Task>> listTasksById(String categoryId) async {
    return await _mongoDbService.listTasksById(categoryId);
  }

  //add new task
  Future<Response> addNewTask(NewTask task) async {
    return await _mongoDbService.addNewTask(task);
  }

  //delete task by giving id
  Future<Response> deleteTaskById(String id) async {
    return await _mongoDbService.deleteTaskById(id);
  }

  //update task by id
  Future<Response> updateTaskById(
      String id, String name, String description, String categoryId) async {
    return await _mongoDbService.updateTaskById(
        id, name, description, categoryId);
  }
}
