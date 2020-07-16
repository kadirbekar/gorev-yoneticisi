import 'package:flutter/material.dart';

class TabbarLabel extends StatelessWidget {
  final String label;
  const TabbarLabel({Key key, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }
}
