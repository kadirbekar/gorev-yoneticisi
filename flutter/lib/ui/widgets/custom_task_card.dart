import 'package:flutter/material.dart';

import '../common_widgets/label_card.dart';

class CustomTaskCard extends StatelessWidget {
  final int index;
  final String title;
  final String subtitle;
  final Function onPressed;
  const CustomTaskCard(
      {Key key, this.index, this.title, this.subtitle, this.onPressed})
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
        trailing: IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red,
              size: 30,
            ),
            onPressed: onPressed),
      ),
    );
  }
}
