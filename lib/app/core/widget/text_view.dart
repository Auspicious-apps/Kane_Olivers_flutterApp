/*
<!--
       
  ~ @author     :Puneet Kumar
  ~ All Rights Reserved.
  ~ Proprietary and confidential :  All information contained herein is, and remains
 
  ~ Unauthorized copying of this file, via any medium is strictly prohibited.
  ~
  -->
 */

import 'package:flutter/material.dart';
import '../../export.dart';

class TextView extends StatelessWidget {
  final String? text;
  final TextStyle? textStyle;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow overflow;

  const TextView({
    Key? key,
    this.text,
    this.textStyle,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      style: textStyle,
      maxLines: maxLines, // Will be null if maxLines is not provided, allowing unlimited lines
      overflow: maxLines != null ? overflow : null, // Only apply overflow if maxLines is set
      textAlign: textAlign,
    );
  }
}