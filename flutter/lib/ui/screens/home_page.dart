import 'package:flutter/material.dart';
import 'package:gorev_yoneticisi/ui/common_widgets/label_card.dart';
import 'package:provider/provider.dart';

import '../../core/constants/color_constants.dart';
import '../../core/models/category_list.dart';
import '../../core/viewmodels/category_view_model.dart';
import '../common_widgets/none_state.dart';
import '../common_widgets/progress_indicator.dart';
import '../widgets/daily_notes.dart';
import '../widgets/modal_bottom_sheet.dart';
import '../widgets/monthly_notes.dart';
import '../widgets/tabbar_items.dart';
import '../widgets/weekly_notes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<CategoryList> _categoryList;
  CategoryListViewModel _categoryListViewModel;
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _categoryList = [];
  }

  @override
  Widget build(BuildContext context) {
    _categoryListViewModel = Provider.of<CategoryListViewModel>(context);
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: true,
        floatingActionButton: addTaskFabButton,
        appBar: appbar,
        body: FutureBuilder(
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return NoneState();
                break;
              case ConnectionState.waiting:
                return MyProgressIndicator();
                break;
              case ConnectionState.active:
              case ConnectionState.done:
                _categoryList = snapshot.data;
                return _categoryList.length > 0 ? tabbarView : Center(child: LabelCard(label: 'Category Not Found, Please Refresh The Page',maxLine: 3,),);
              default:
                return null;
            }
          },
          future: _categoryListViewModel.getAllCategories(),
        ),
      ),
    );
  }

  Widget get appbar => AppBar(
        bottom: tabbarItems,
        centerTitle: true,
        backgroundColor: UIColorHelper.DEFAULT_COLOR,
        title: const Text(
          "Saved Notes",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      );

  Widget get addTaskFabButton => FloatingActionButton(
        backgroundColor: UIColorHelper.DEFAULT_COLOR,
        onPressed: _showModalSheet,
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      );

  void _showModalSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      context: context,
      builder: (builder) {
        return MyModelBottomSheet(
          scaffoldKey: _scaffoldKey,
          parent: this,
        );
      },
    );
  }

  Widget get tabbarItems => TabBar(
        indicatorColor: Colors.brown,
        tabs: [
          Tab(
            child: const TabbarLabel(
              label: 'Daily',
            ),
          ),
          Tab(
            child: const TabbarLabel(
              label: 'Weekly',
            ),
          ),
          Tab(
            child: const TabbarLabel(
              label: 'Monthly',
            ),
          ),
        ],
      );

  Widget get tabbarView => TabBarView(
        children: [
          DailyNotes(
            categoryId: _categoryList[0].id,
            scaffoldKey: _scaffoldKey,
          ),
          WeeklyNotes(
            categoryId: _categoryList[1].id,
            scaffoldKey: _scaffoldKey,
          ),
          MonthlyNotes(
            categoryId: _categoryList[2].id,
            scaffold: _scaffoldKey,
          ),
        ],
      );
}
