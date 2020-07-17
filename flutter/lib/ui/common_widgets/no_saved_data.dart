import 'package:flutter/material.dart';

class NoSavedData extends StatelessWidget {
  const NoSavedData({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.data_usage,
            size: 30,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "No Saved Data",
            style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
