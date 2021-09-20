import 'package:flutter/material.dart';
/*fonts*/
const fontRegular = 'Regular';
const fontMedium = 'Medium';
const fontSemibold = 'Semibold';
const fontBold = 'Bold';
/* font sizes*/
const textSizeSmall = 12.0;
const textSizeSMedium = 14.0;
const textSizeMedium = 16.0;
const textSizeLargeMedium = 18.0;
const textSizeNormal = 20.0;
const textSizeLarge = 24.0;
const textSizeXLarge = 30.0;
const textSizeXXLarge = 35.0;

Widget customText(
    var text, {
      var fontSize = textSizeMedium,
      textColor = "",
      var fontFamily = fontRegular,
      var isCentered = false,
      var maxLine = 1,
      var latterSpacing = 0.2,
      var isLongText = false,
      var isJustify = false,
    }) {
  return Text(
    text,
    textAlign: isCentered
        ? TextAlign.center
        : isJustify ? TextAlign.justify : TextAlign.start,
    maxLines: isLongText ? 20 : maxLine,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
        fontFamily: fontFamily,
        fontSize: double.parse(fontSize.toString()).toDouble(),
        height: 1.5,
        color: textColor.toString().isNotEmpty ? textColor : null,
        letterSpacing: latterSpacing),
  );
}
