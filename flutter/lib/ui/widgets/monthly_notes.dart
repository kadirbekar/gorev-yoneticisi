import 'package:flutter/material.dart';

class MonthlyNotes extends StatefulWidget {
  MonthlyNotes({Key key}) : super(key: key);

  @override
  _MonthlyNotesState createState() => _MonthlyNotesState();
}

class _MonthlyNotesState extends State<MonthlyNotes> {

  @override
  void initState() {
    super.initState();
    print("aylık");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Monthly Notes"),
      ),
    );
  }
}
