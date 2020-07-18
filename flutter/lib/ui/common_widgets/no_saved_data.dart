import 'package:flutter/material.dart';
import 'package:gorev_yoneticisi/ui/common_widgets/label_card.dart';
import 'package:gorev_yoneticisi/ui/shared_settings/responsive.dart';

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
