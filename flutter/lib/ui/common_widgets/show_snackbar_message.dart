import 'package:flutter/material.dart';

import '../shared_settings/responsive.dart';
import 'label_card.dart';

class ShowSnackbarMessage extends StatelessWidget {
  final String message;
  const ShowSnackbarMessage({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      alignment: Alignment.center,
      height: SizeConfig.safeBlockVertical * 4.5,
      width: double.infinity,
      child: LabelCard(
        label: message,
        maxLine: 3,
        fontSize: SizeConfig.safeBlockHorizontal * 4,
      ),
    );
  }
}
