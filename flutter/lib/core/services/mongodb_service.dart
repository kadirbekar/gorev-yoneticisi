import 'package:http/http.dart' as http;

import '../constants/app_constants.dart';
import '../constants/method_constants.dart';
import '../models/category_list.dart';

//singleton instance created
class MongoDbService {
  static MongoDbService _instance;
  static MongoDbService get instance {
    if (_instance == null) _instance = MongoDbService._init();
    return _instance;
  }

  MongoDbService._init();

  //list all categories
  Future<List<CategoriList>> getAllCategories() async {
    List<CategoriList> allCategories = [];
    try {
      final request = await http.get(ApiConstant.SERVICE_URL + MethodConstants.listAllCategories,headers: ApiConstant.HEADERS);
      if (request.statusCode == 200) {
        allCategories = categoriListFromJson(request.body);
      } else {
        print(request.statusCode);
      }
    } catch (e) {
      return List<CategoriList>();
    }
    return allCategories;
  }
}
