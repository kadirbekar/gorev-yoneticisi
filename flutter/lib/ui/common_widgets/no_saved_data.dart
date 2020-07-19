import 'package:flutter/material.dart';

import '../shared_settings/responsive.dart';
import 'label_card.dart';

class NoSavedData extends StatelessWidget {
  const NoSavedData({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
          LabelCard(
            label: 'No Saved Data',
            fontSize: SizeConfig.safeBlockHorizontal * 4.5,
          ),
        ],
      ),
    );
  }
}
