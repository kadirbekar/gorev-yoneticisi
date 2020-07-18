import 'package:flutter/material.dart';
import 'package:gorev_yoneticisi/core/constants/color_constants.dart';

import '../common_widgets/label_card.dart';

class CustomTaskCard extends StatelessWidget {
  final int index;
  final String title;
  final String subtitle;
  final Function editOnPressed;
  final Function deleteOnPressed;
  const CustomTaskCard(
      {Key key, this.index, this.title, this.subtitle, this.editOnPressed,this.deleteOnPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          child: Text((index + 1).toString()),
        ),
        title: LabelCard(
          label: title,
          maxLine: 2,
          fontWeight: FontWeight.bold,
        ),
        subtitle: LabelCard(
          label: subtitle,
          maxLine: 5,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              color: UIColorHelper.DEFAULT_COLOR,
              onPressed: editOnPressed,
              icon: Icon(
                Icons.edit,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            IconButton(
              color: UIColorHelper.DEFAULT_COLOR,
              onPressed: deleteOnPressed,
              icon: Icon(Icons.delete),
            ),
            SizedBox(
              width: 5,
            ),
          ],
        ),
      ),
    );
  }
}
