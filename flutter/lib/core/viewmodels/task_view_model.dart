import 'package:flutter/cupertino.dart';

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

  Future<List<Task>> listTasksById(String categoryId) async{
    try {
      taskList = await  _repositoryService.listTasksById(categoryId);
    } catch (e) {
      state = TaskState.ErrorState;
    }
    return taskList;
  }
}
