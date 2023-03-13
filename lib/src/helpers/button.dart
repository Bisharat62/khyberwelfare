import 'package:flutter/material.dart';

import 'color.dart';
import 'const_text.dart';

Widget buttonmain(VoidCallback ontap, String text, double width, context,
    {double? height,
    Color? color,
    bool? noborder,
    Widget? child,
    bool? showborder,
    double? fsize}) {
  return InkWell(
    onTap: ontap,
    child: Container(
      width: MediaQuery.of(context).size.width * width,
      height: height ?? 45,
      decoration: BoxDecoration(
        color: color ?? Ccolor.btnbg,
        border:
            Border.all(width: showborder == true ? 1 : 0, color: Colors.black),
        borderRadius: BorderRadius.circular((noborder == true) ? 0 : 25),
      ),
      child: child ??
          Center(
            child: boldtext(Ccolor.textwhite, fsize ?? 18, text),
          ),
    ),
  );
}
