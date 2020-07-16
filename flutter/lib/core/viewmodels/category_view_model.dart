import 'package:flutter/cupertino.dart';
import 'package:gorev_yoneticisi/core/models/category_list.dart';
import 'package:gorev_yoneticisi/core/services/repository_service.dart';

enum DataState { InitialState, LoadingState, LoadedState, ErrorState }

class CategoryListViewModel with ChangeNotifier {
  List<CategoriList> _categoryList;
  RepositoryService _repositoryService = RepositoryService.instance;
  DataState _state;

  CategoryListViewModel() {
    _categoryList = [];
    _state = DataState.InitialState;
  }

  DataState get state => _state;

  //set new state
  set state(DataState value){
    _state = value;
    notifyListeners();
  }

  Future<List<CategoriList>> getAllCategories() async{
    try {
      _categoryList = await _repositoryService.getAllCategories();
    } catch (e) {
      state = DataState.ErrorState;
    }
    return _categoryList;
  }
}
