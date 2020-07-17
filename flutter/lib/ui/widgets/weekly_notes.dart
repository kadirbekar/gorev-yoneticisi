import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/task.dart';
import '../../core/viewmodels/task_view_model.dart';
import '../common_widgets/no_saved_data.dart';
import '../common_widgets/none_state.dart';
import '../common_widgets/progress_indicator.dart';

class WeeklyNotes extends StatefulWidget {
  final String categoryId;
  WeeklyNotes({Key key, @required this.categoryId}) : super(key: key);

  @override
  _WeeklyNotesState createState() => _WeeklyNotesState();
}

class _WeeklyNotesState extends State<WeeklyNotes> {
  TaskViewModel _taskViewModel;
  List<Task> _taskList;

  @override
  void initState() {
    super.initState();
    _taskList = [];
  }

  @override
  Widget build(BuildContext context) {
    _taskViewModel = Provider.of<TaskViewModel>(context, listen: false);
    return Scaffold(
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
                _taskList = snapshot.data;
                return showResult;
              default:
                return null;
            }
          },
          future: _taskViewModel.listTasksById(widget.categoryId)),
    );
  }

  Widget get showResult => ListView.builder(
        itemBuilder: (context, index) {
          if (_taskList.length > 0) {
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: Text((index + 1).toString()),
                ),
                title: Text(_taskList[index].name),
                subtitle: Text(_taskList[index].description),
              ),
            );
          } else {
            return NoSavedData();
          }
        },
        itemCount: _taskList.length,
      );
}
