import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'color.dart';

Widget boldtext(
  Color tcolor,
  double tsize,
  String text, {
  bool? center,
}) {
  return Text(
    text,
    textAlign: (center == true) ? TextAlign.center : TextAlign.left,
    style: TextStyle(
        color: tcolor,
        fontSize: tsize,
        fontWeight: FontWeight.bold,
        fontFamily: 'poppins_bold'),
  );
}

Widget regulartext(Color tcolor, double tsize, String text, {bool? center}) {
  return Text(
    text,
    textAlign: (center == true) ? TextAlign.center : TextAlign.left,
    style: TextStyle(
        color: tcolor, fontSize: tsize, fontFamily: 'poppins_regular'),
  );
}

Widget mediumtext(Color tcolor, double tsize, String text, {bool? center}) {
  return Text(
    text,
    textAlign: (center == true) ? TextAlign.center : TextAlign.left,
    style:
        TextStyle(color: tcolor, fontSize: tsize, fontFamily: 'poppins_medium'),
  );
}

Widget lighttext(Color tcolor, double tsize, String text, {bool? center}) {
  return Text(
    text,
    textAlign: (center == true) ? TextAlign.center : TextAlign.left,
    style:
        TextStyle(color: tcolor, fontSize: tsize, fontFamily: 'poppins_light'),
  );
}

Widget newuser(context, String text1, String text2, Widget child) {
  return Padding(
    padding: const EdgeInsets.only(left: 10),
    child: Row(
      children: [
        boldtext(Ccolor.texthint, 13, text1),
        InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => child));
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: boldtext(Ccolor.btnbg, 13, text2),
          ),
        ),
      ],
    ),
  );
}
