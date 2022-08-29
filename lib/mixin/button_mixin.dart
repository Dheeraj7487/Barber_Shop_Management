import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class ButtonMixin {
  Widget appButton(
      {
        VoidCallback? onPress,
        String? text,
        double? fontSize,
        FontWeight?fontWeight,
        double? width,
        double? height,
        Color? bgColor,
        Color? textColor,
        BoxDecoration? boxDecoration,
      }){

    var boxDecoration = BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      color: AppColor.beachColor4
    );

    return Container(
      padding: const EdgeInsets.only(left: 30,right: 30,top: 15,bottom: 15),
      width: double.infinity,
      decoration:boxDecoration,
      child: Center(child: Text(text!,style: const TextStyle(letterSpacing:0.5,color: Colors.white,fontSize: 16))),
    );
  }
}