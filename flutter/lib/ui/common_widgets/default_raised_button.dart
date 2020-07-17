import 'package:flutter/material.dart';

class DefaultRaisedButton extends StatelessWidget {
  final String label;
  final double height;
  final double width;
  final double leftBorderRadiusValue;
  final double rightBorderRadiusValue;
  final Function onPressed;
  final TextStyle textStyle;
  final Color color;

  DefaultRaisedButton(
      {this.label,
      this.height,
      this.width,
      this.leftBorderRadiusValue,
      this.rightBorderRadiusValue,
      this.onPressed,
      this.textStyle,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      width: this.width,
      child: RaisedButton(
        color: Colors.teal,
        onPressed: this.onPressed,
        child: Text(
          this.label ?? "unnamed",
          style: this.textStyle,
        ),
      ),
    );
  }
}
