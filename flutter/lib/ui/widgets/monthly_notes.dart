import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/task.dart';
import '../../core/viewmodels/task_view_model.dart';
import '../common_widgets/no_saved_data.dart';
import '../common_widgets/none_state.dart';
import '../common_widgets/progress_indicator.dart';
import '../common_widgets/show_snackbar_message.dart';
import '../shared_settings/responsive.dart';
import 'custom_task_card.dart';

class MonthlyNotes extends StatefulWidget {
  final String categoryId;
  final GlobalKey<ScaffoldState> scaffold;
  MonthlyNotes({Key key, @required this.categoryId, this.scaffold})
      : super(key: key);

  @override
  _MonthlyNotesState createState() => _MonthlyNotesState();
}

class _MonthlyNotesState extends State<MonthlyNotes> {
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
              }, editOnPressed: (){},
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
    widget.scaffold.currentState.showSnackBar(snackBar);
  }
}
