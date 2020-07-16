import 'package:flutter/material.dart';
import 'package:gorev_yoneticisi/core/models/category_list.dart';
import 'package:gorev_yoneticisi/core/viewmodels/category_view_model.dart';
import 'package:provider/provider.dart';

class DailyNotes extends StatefulWidget {
  DailyNotes({Key key}) : super(key: key);

  @override
  _DailyNotesState createState() => _DailyNotesState();
}

class _DailyNotesState extends State<DailyNotes> {
  List<CategoriList> _categoryList;

  @override
  void initState() {
    super.initState();
    _categoryList = [];
  }

  @override
  Widget build(BuildContext context) {
    var _categoryListViewModel = Provider.of<CategoryListViewModel>(context);
    return Scaffold(
      body: FutureBuilder(
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text("none");
              break;
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator(),);
              break;
            case ConnectionState.active:
            case ConnectionState.done:
              _categoryList = snapshot.data;
              return ListView.builder(itemBuilder: (context,index){
                return Text(_categoryList[index].name);
              },itemCount: _categoryList.length,);
            default:
              return null;
          }
        },
        future: _categoryListViewModel.getAllCategories(),
      ),
    );
  }
}
