import 'package:flutter/material.dart';

import '../../core/constants/color_constants.dart';
import '../widgets/daily_notes.dart';
import '../widgets/monthly_notes.dart';
import '../widgets/tabbar_items.dart';
import '../widgets/weekly_notes.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          bottom: tabbarItems,
          centerTitle: true,
          backgroundColor: UIColorHelper.DEFAULT_COLOR,
          title: const Text(
            "Saved Notes",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: TabBarView(
          children: [
            DailyNotes(),
            WeeklyNotes(),
            MonthlyNotes(),
          ],
        ),
      ),
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
}
