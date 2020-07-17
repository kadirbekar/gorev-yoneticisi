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

  Future<List<CategoryList>> getAllCategories() async {
    return await _mongoDbService.getAllCategories();
  }

  Future<List<Task>> listTasksById(String categoryId) async {
    return await _mongoDbService.listTasksById(categoryId);
  }
}
