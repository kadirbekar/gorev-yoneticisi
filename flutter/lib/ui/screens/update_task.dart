import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/color_constants.dart';
import '../../core/models/category_list.dart';
import '../../core/models/task.dart';
import '../../core/viewmodels/category_view_model.dart';
import '../../core/viewmodels/task_view_model.dart';
import '../common_methods/focus_node.dart';
import '../common_methods/form_value_control.dart';
import '../common_widgets/default_raised_button.dart';
import '../common_widgets/label_card.dart';
import '../common_widgets/show_snackbar_message.dart';
import '../common_widgets/text_form_field.dart';
import '../shared_settings/responsive.dart';

class UpdateTask extends StatefulWidget {
  final Task task;
  final Function setState;

  const UpdateTask({Key key, this.task, this.setState}) : super(key: key);

  @override
  _UpdateTaskState createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  var _nameController = TextEditingController();
  var _descriptionController = TextEditingController();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<CategoryList> categoryList;
  CategoryList currentCategory;
  var firstCategory;

  bool autoControl = false;

  @override
  void initState() {
    super.initState();
    categoryList = [];
    _nameController.text = widget.task.name;
    _descriptionController.text = widget.task.description;
    Provider.of<CategoryListViewModel>(context, listen: false)
        .categoryList
        .forEach((element) {
      try {
        setState(() {
          categoryList.add(element);
          currentCategory = categoryList[0];
          firstCategory = categoryList[0].id;
        });
      } catch (e) {
        print(e.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: LabelCard(
            label: 'Update Task',
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
          backgroundColor: UIColorHelper.DEFAULT_COLOR,
        ),
        body: Builder(
          builder: (context) => Container(
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            child: Form(
              autovalidate: autoControl,
              key: _formKey,
              child: Column(
                children: <Widget>[
                  nameTextFormField,
                  SizedBox(height: 5),
                  descriptionTextFormField,
                  SizedBox(height: 15),
                  dropDownItems,
                  SizedBox(height: 15),
                  DefaultRaisedButton(
                    label: 'Update',
                    textStyle:
                        TextStyle(fontSize: SizeConfig.safeBlockVertical * 4),
                    height: SizeConfig.safeBlockVertical * 6.5,
                    width: double.infinity,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        Provider.of<TaskViewModel>(context, listen: false)
                            .updateTaskById(
                          widget.task.id,
                          _nameController.text,
                          _descriptionController.text,
                          firstCategory,
                        )
                            .then((result) {
                          if (result.result == true) {
                            showSnackbar(result.message);
                            widget.setState();
                            Navigator.pop(context);
                          } else {
                            Navigator.pop(context);
                            showSnackbar(result.message);
                          }
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get nameTextFormField => MyTextFormField(
        label: 'Task Name',
        labelText: 'Task Name',
        lineCount: 1,
        controller: _nameController,
        focusNode: _nameFocusNode,
        nextButton: TextInputAction.next,
        onFieldSubmitted: (next) {
          fieldFocusChange(context, _nameFocusNode, _descriptionFocusNode);
        },
        validationFunction: RegexKontrol.valueLenghtControl,
      );

  Widget get descriptionTextFormField => MyTextFormField(
        label: 'Description',
        labelText: 'Description',
        lineCount: 2,
        controller: _descriptionController,
        focusNode: _descriptionFocusNode,
        nextButton: TextInputAction.done,
        validationFunction: RegexKontrol.valueLenghtControl,
      );

  Widget get dropDownItems => DropdownButton<CategoryList>(
        onChanged: (CategoryList value) {
          setState(() {
            print(value.name);
            currentCategory = value;
            firstCategory = currentCategory.id;
          });
        },
        icon: Icon(
          Icons.arrow_drop_down,
          size: SizeConfig.blockSizeVertical * 5,
          color: Colors.black,
        ),
        underline: Container(
          height: 2,
          color: Colors.black,
          width: double.infinity,
        ),
        value: currentCategory,
        items: categoryList.map((CategoryList eachCategory) {
          return DropdownMenuItem<CategoryList>(
            value: eachCategory,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: LabelCard(
                label: eachCategory.name,
                fontSize: SizeConfig.safeBlockHorizontal * 5.5,
              ),
            ),
          );
        }).toList(),
      );

  showSnackbar(String message) {
    final snackBar = SnackBar(
      content: ShowSnackbarMessage(
        message: message,
      ),
      duration: Duration(milliseconds: 1300),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
