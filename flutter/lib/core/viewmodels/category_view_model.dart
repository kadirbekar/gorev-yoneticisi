import 'package:flutter/cupertino.dart';

import '../models/category_list.dart';
import '../services/repository_service.dart';

enum DataState { InitialState, LoadingState, LoadedState, ErrorState }

class CategoryListViewModel with ChangeNotifier {
  List<CategoryList> categoryList;
  RepositoryService _repositoryService = RepositoryService.instance;
  DataState _state;

  CategoryListViewModel() {
    categoryList = [];
    _state = DataState.InitialState;
  }

  DataState get state => _state;

  //set new state
  set state(DataState value){
    _state = value;
    notifyListeners();
  }

  Future<List<CategoryList>> getAllCategories() async{
    try {
      categoryList = await _repositoryService.getAllCategories();
    } catch (e) {
      state = DataState.ErrorState;
    }
    return categoryList;
  }
}
