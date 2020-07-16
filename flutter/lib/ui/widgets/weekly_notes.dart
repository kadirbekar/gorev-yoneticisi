import 'package:flutter/material.dart';

class WeeklyNotes extends StatefulWidget {
  WeeklyNotes({Key key}) : super(key: key);

  @override
  _WeeklyNotesState createState() => _WeeklyNotesState();
}

class _WeeklyNotesState extends State<WeeklyNotes> {

  @override
  void initState() {
    super.initState();
    print("hafalık");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Weekly Notes"),
      ),
    );
  }
}
