import'package:flutter/material.dart';
import'dart:ui';
Color  primaryColor =  Colors.white;
class CustomText {
  static TextStyle header ({Color ? color , double ? height}){
    return TextStyle(
     fontSize: 20,
      fontWeight: FontWeight.bold,
      color: color ?? Colors.white,
      height: height,
    );
  }
  static TextStyle subheader({Color? color, FontWeight? fontWeight, double? height}) {
    return TextStyle(
      fontSize: 16.0,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color ?? Colors.white,
      height: height,
    );
  }
}