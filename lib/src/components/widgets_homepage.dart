import 'package:flutter/material.dart';
import 'package:khyberwelfareforum/src/helpers/spacer.dart';

import '../helpers/color.dart';
import '../helpers/const_text.dart';

class ContainerCard extends StatelessWidget {
  String text;
  String img;
  Widget? navigator;
  ContainerCard(
      {super.key, required this.text, required this.img, this.navigator});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (navigator != null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => navigator!));
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.35,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Ccolor.btnbg.withOpacity(0.7)),
        child: Column(
          children: [
            boldtext(Ccolor.textblack, 15, text, center: true),
            vertical(15),
            Image.asset(
              img,
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
