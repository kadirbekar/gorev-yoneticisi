import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'core/viewmodels/category_view_model.dart';
import 'core/viewmodels/task_view_model.dart';
import 'ui/screens/home_page.dart';

void main() {
  runApp(MyApp());

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CategoryListViewModel>(create: (context) => CategoryListViewModel()),
        ChangeNotifierProvider<TaskViewModel>(create: (context) => TaskViewModel()),
      ],
          child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Montserrat'
        ),
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
