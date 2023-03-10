import 'package:flutter/material.dart';
import 'package:khyberwelfareforum/src/helpers/spacer.dart';

import '../helpers/color.dart';
import '../helpers/const_text.dart';

class ContainerCard extends StatelessWidget {
  String text;
  String img;
  Widget? navigator;
  VoidCallback? ontap;
  ContainerCard(
      {super.key,
      required this.text,
      required this.img,
      this.navigator,
      this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap ??
          () {
            if (navigator != null) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => navigator!));
            }
          },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: 130,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Ccolor.btnbg),
        child: Column(
          children: [
            SizedBox(
                height: 40,
                child: boldtext(Ccolor.textblack, 15, text, center: true)),
            vertical(15),
            Image.asset(
              img,
              height: 35,
            )
          ],
        ),
      ),
    );
  }
}
