import 'package:flutter/material.dart';
import 'package:gorev_yoneticisi/core/models/category_list.dart';
import 'package:gorev_yoneticisi/core/viewmodels/category_view_model.dart';
import 'package:provider/provider.dart';

import '../../core/constants/color_constants.dart';
import '../common_methods/focus_node.dart';
import '../common_widgets/default_raised_button.dart';
import '../common_widgets/text_form_field.dart';
import '../shared_settings/responsive.dart';

class MyModelBottomSheet extends StatefulWidget {
  MyModelBottomSheet({Key key}) : super(key: key);

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

  @override
  void initState() {
    super.initState();
    categoryList = [];
    Provider.of<CategoryListViewModel>(context, listen: false).getAllCategories().then((category) {
      try {
        category.forEach((element) {
          print(element.name);
        });
        if (category[0] != null) {
          categoryList = category;
          currentCategory = category[0];
          firstCategory = category[0].id;
        }
      } catch (e) {
        print(e.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      color: Colors.teal[100],
      height: SizeConfig.safeBlockVertical * 80,
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            nameTextFormField,
            SizedBox(height: 5),
            descriptionTextFormField,
            SizedBox(height: 15),
            DropdownButton<CategoryList>(
              icon: Icon(
                Icons.arrow_drop_down,
                size: SizeConfig.blockSizeVertical * 5,
                color: Colors.black,
              ),
              underline: Container(
                height: 2,
                color: Colors.black,
              ),
              value: currentCategory,
              onChanged: (CategoryList value) {
                setState(() {
                  currentCategory = value;
                  firstCategory = currentCategory.id;
                });
              },
              items: categoryList.map((CategoryList category) {
                return DropdownMenuItem<CategoryList>(
                  value: currentCategory,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Text(
                      currentCategory.name,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                );
              }).toList(),
            ),
            saveButton,
          ],
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
      );

  Widget get descriptionTextFormField => MyTextFormField(
        label: 'Description',
        labelText: 'Description',
        lineCount: 2,
        controller: _descriptionController,
        focusNode: _descriptionFocusNode,
        nextButton: TextInputAction.done,
      );

  Widget get saveButton => DefaultRaisedButton(
        height: SizeConfig.safeBlockVertical * 8,
        label: 'Save',
        onPressed: () {},
        color: UIColorHelper.DEFAULT_COLOR,
        width: double.infinity,
        textStyle: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 6.5),
      );
}
