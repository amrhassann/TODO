import 'package:flutter/material.dart';
import 'package:todo_app/presentation/res/colors_manager.dart';
import 'package:todo_app/presentation/res/fonts_manager.dart';

TextStyle _getTextStyle({
  required Color color,
  required FontWeight fontWeight,
  required double fontSize,
  TextDecoration? decoration,
}) {
  return TextStyle(
    color: color,
    fontWeight: fontWeight,
    fontFamily: FontFamilies.kufam,
    fontSize: fontSize,
      decoration: decoration
  );
}


// light
getLightStyle({
  required Color color,
  required double fontSize,
  TextDecoration? decoration,
}) {
  return _getTextStyle(
    color: color,
    fontWeight: FontsWeightsManager.light,
    fontSize: fontSize,
    decoration: decoration
  );
}

// regular
getRegularStyle({
  required Color color,
  required double fontSize,
  TextDecoration? decoration,
}) {
  return _getTextStyle(
    color: color,
    fontWeight: FontsWeightsManager.regular,
    fontSize: fontSize,
    decoration: decoration
  );
}

// medium
getMediumStyle({
  required Color color,
  required double fontSize,
  TextDecoration? decoration,
}) {
  return _getTextStyle(
    color: color,
    fontWeight: FontsWeightsManager.medium,
    fontSize: fontSize,
    decoration: decoration
  );
}

// SemiBold
getSemiBoldStyle({
  required Color color,
  required double fontSize,
  TextDecoration? decoration,
}) {
  return _getTextStyle(
    color: color,
    fontWeight: FontsWeightsManager.semiBold,
    fontSize: fontSize,
    decoration: decoration
  );
}

// Bold
getBoldStyle({
  required Color color,
  required double fontSize,
  TextDecoration? decoration,
}) {
  return _getTextStyle(
    color: color,
    fontWeight: FontsWeightsManager.bold,
    fontSize: fontSize,
    decoration: decoration
  );
}


OutlineInputBorder borderStyle() {
  return OutlineInputBorder(
      borderSide: BorderSide(
        color: ColorsManager.lightGray1,
      ),
      borderRadius: BorderRadius.circular(10));
}

getTextFieldStyle({Widget? suffixIcon, required String hintText}){
  return InputDecoration(
      enabledBorder: borderStyle() ,
      border: borderStyle() ,
      focusedBorder: borderStyle() ,
      disabledBorder: borderStyle(),
      errorBorder: borderStyle(),

      suffixIcon: suffixIcon,
      hintText: hintText,
      hintStyle:  const TextStyle(color: ColorsManager.gray),

      filled: true,
      fillColor: ColorsManager.lightGray1);
}