import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/task.dart';
import '../../core/viewmodels/task_view_model.dart';
import '../common_widgets/no_saved_data.dart';
import '../common_widgets/none_state.dart';
import '../common_widgets/progress_indicator.dart';
import '../common_widgets/show_snackbar_message.dart';
import '../screens/update_task.dart';
import '../shared_settings/responsive.dart';
import 'custom_task_card.dart';

class WeeklyNotes extends StatefulWidget {
  final String categoryId;
  final GlobalKey<ScaffoldState> scaffoldKey;
  WeeklyNotes({Key key, @required this.categoryId, this.scaffoldKey})
      : super(key: key);

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
    SizeConfig().init(context);
    _taskViewModel = Provider.of<TaskViewModel>(context, listen: false);
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
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
                  return _taskList.length > 0 ? showResult : NoSavedData();
                default:
                  return null;
              }
            },
            future: _taskViewModel.listTasksById(widget.categoryId)),
      ),
    );
  }

  Widget get showResult => ListView.builder(
        itemBuilder: (context, index) {
          if (_taskList.length > 0) {
            return CustomTaskCard(
              title: _taskList[index].name,
              subtitle: _taskList[index].description,
              index: index,
              deleteOnPressed: () {
                Provider.of<TaskViewModel>(context, listen: false)
                    .deleteTaskById(_taskList[index].id)
                    .then((result) {
                  if (result.result == true) {
                    showSnackbar(result.message);
                    setState(() {});
                  } else {
                    showSnackbar(result.message);
                  }
                });
              },
              editOnPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdateTask(
                              task: _taskList[index],
                              setState: () {
                                setState(() {});
                              },
                            )));
              },
            );
          } else {
            return NoSavedData();
          }
        },
        itemCount: _taskList.length,
      );

  showSnackbar(String message) {
    final snackBar = SnackBar(
      content: ShowSnackbarMessage(
        message: message,
      ),
      duration: Duration(milliseconds: 1300),
    );
    widget.scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
