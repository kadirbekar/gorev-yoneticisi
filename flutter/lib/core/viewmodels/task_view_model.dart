import 'package:flutter/cupertino.dart';
import 'package:gorev_yoneticisi/core/models/add_new_task.dart';
import 'package:gorev_yoneticisi/core/models/common_response.dart';

import '../models/task.dart';
import '../services/repository_service.dart';

enum TaskState { InitialState, LoadingState, LoadedState, ErrorState }

class TaskViewModel with ChangeNotifier{
  RepositoryService _repositoryService = RepositoryService.instance;
  List<Task> taskList;
  TaskState _state;

  TaskViewModel(){
    taskList = List<Task>();
    _state = TaskState.InitialState;
  }

  TaskState get state => _state;

  set state(TaskState value) {
    _state = value;
    notifyListeners();
  }

  //get category by id
  Future<List<Task>> listTasksById(String categoryId) async{
    try {
      taskList = await  _repositoryService.listTasksById(categoryId);
    } catch (e) {
      state = TaskState.ErrorState;
    }
    return taskList;
  }

  //add new task
  Future<Response> addNewTask(NewTask task) async {
    Response response = Response();
    try {
      response = await _repositoryService.addNewTask(task);
    } catch (e) {
      state = TaskState.ErrorState;
    }
    return response;
  }

  //delete task by giving id
  Future<Response> deleteTaskById(String id) async {
    Response response = Response();
    try {
      response = await _repositoryService.deleteTaskById(id);
    } catch (e) {
      state = TaskState.ErrorState;
    }
    return response;
  }
}
