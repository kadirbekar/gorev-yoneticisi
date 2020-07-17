import 'package:http/http.dart' as http;

import '../constants/app_constants.dart';
import '../constants/method_constants.dart';
import '../models/category_list.dart';
import '../models/task.dart';

//singleton instance created
class MongoDbService {
  static MongoDbService _instance;
  static MongoDbService get instance {
    if (_instance == null) _instance = MongoDbService._init();
    return _instance;
  }

  MongoDbService._init();

  //list all categories
  Future<List<CategoryList>> getAllCategories() async {
    List<CategoryList> allCategories = [];
    try {
      final request = await http.get(ApiConstant.SERVICE_URL + MethodConstants.listAllCategories,headers: ApiConstant.HEADERS);
      if (request.statusCode == 200) {
        allCategories = categoriListFromJson(request.body);
      } else {
        print(request.statusCode);
      }
    } catch (e) {
      return List<CategoryList>();
    }
    return allCategories;
  }

  //list tasks by category id
  Future<List<Task>> listTasksById(String categoryId) async{
    List<Task> taskList = [];
    try {
      String json = '{"categoryId" : "$categoryId"}';
      final request = await http.post(ApiConstant.SERVICE_URL+MethodConstants.listTasksById,headers: ApiConstant.HEADERS,body: json);
      if(request.statusCode == 200){
        taskList = taskFromJson(request.body);
      } else {
        print(request.statusCode);
      }
    } catch (e) {
      return List<Task>();
    }
    return taskList;
  }
}
