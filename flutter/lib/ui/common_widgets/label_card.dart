import 'package:flutter/material.dart';

class LabelCard extends StatefulWidget {
  final Color color;
  final MediaQuery mediaQuery;
  final EdgeInsetsGeometry padding;
  final Alignment alignment;
  final TextStyle textStyle;
  final String label;
  final double fontSize;
  final FontWeight fontWeight;
  final int maxLine;
  final TextAlign textAlign;
  final String fontFamily;

  LabelCard(
      {Key key,
      this.fontSize,
      this.color,
      this.textAlign,
      this.fontWeight,
      this.maxLine,
      this.label,
      this.mediaQuery,
      this.textStyle,
      this.alignment,
      this.padding,
      this.fontFamily})
      : super(key: key);

  @override
  _LabelCardState createState() => _LabelCardState();
}

class _LabelCardState extends State<LabelCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      alignment: widget.alignment,
      child: Text(
        widget.label,
        overflow: TextOverflow.ellipsis,
        maxLines: widget.maxLine,
        textAlign: widget.textAlign,
        style: TextStyle(
          fontFamily: widget.fontFamily,
          fontSize: widget.fontSize,
          fontWeight: widget.fontWeight,
          color: widget.color,
        ),
      ),
    );
  }
}
