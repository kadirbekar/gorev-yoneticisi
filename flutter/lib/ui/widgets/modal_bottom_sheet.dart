import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/add_new_task.dart';
import '../../core/models/category_list.dart';
import '../../core/viewmodels/category_view_model.dart';
import '../../core/viewmodels/task_view_model.dart';
import '../common_methods/focus_node.dart';
import '../common_methods/form_value_control.dart';
import '../common_widgets/default_raised_button.dart';
import '../common_widgets/label_card.dart';
import '../common_widgets/text_form_field.dart';
import '../screens/home_page.dart';
import '../shared_settings/responsive.dart';

class MyModelBottomSheet extends StatefulWidget {
  final HomePageState parent;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const MyModelBottomSheet({Key key, this.parent, this.scaffoldKey})
      : super(key: key);

  @override
  _MyModelBottomSheetState createState() => _MyModelBottomSheetState();
}

class _MyModelBottomSheetState extends State<MyModelBottomSheet> {
  var _nameController = TextEditingController();
  var _descriptionController = TextEditingController();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  List<CategoryList> categoryList;
  CategoryList currentCategory;
  var firstCategory;

  bool autoControl = false;

  @override
  void initState() {
    super.initState();
    categoryList = [];
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
      child: Container(
        color: Colors.teal[100],
        height: SizeConfig.safeBlockVertical * 80,
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
                label: 'Save',
                textStyle: TextStyle(fontSize: SizeConfig.safeBlockVertical * 4.5),
                height: SizeConfig.safeBlockVertical * 6.5,
                width: double.infinity,
                onPressed: () {
                  Provider.of<TaskViewModel>(context, listen: false)
                      .addNewTask(NewTask(
                          name: _nameController.text,
                          description: _descriptionController.text,
                          categoryId: firstCategory))
                      .then((result) {
                    if (result.result == true) {
                      Navigator.pop(context);
                      showSnackbar(result.message);
                      widget.parent.setState(() {});
                    } else {
                      showSnackbar(result.message);
                    }
                  });
                },
              ),
            ],
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
      content: Container(
        alignment: Alignment.center,
        height: SizeConfig.safeBlockVertical * 4.5,
        width: double.infinity,
        child: LabelCard(
          label: message,
          maxLine: 3,
          fontSize: SizeConfig.safeBlockHorizontal * 3.8,
        ),
      ),
      duration: Duration(milliseconds: 1300),
    );
    widget.scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
