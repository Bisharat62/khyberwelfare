import 'package:flutter/material.dart';

import '../../../../components/assets.dart';
import '../../../../components/globals.dart';
import '../../../../helpers/color.dart';
import '../../../../helpers/const_text.dart';

class AddDatabaseHeader extends StatefulWidget {
  String imgurl;
  bool? view;
  VoidCallback ontap;
  String? formno;
  AddDatabaseHeader(
      {super.key,
      required this.imgurl,
      required this.ontap,
      this.formno,
      this.view});

  @override
  State<AddDatabaseHeader> createState() => _AddDatabaseHeaderState();
}

class _AddDatabaseHeaderState extends State<AddDatabaseHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(color: Ccolor.texthint, width: 1.5)),
            child: boldtext(
                Ccolor.textblack,
                10,
                widget.formno == null
                    ? "Form No : ${USEREMAIL!.split("@").first}$ADDEDFORMS"
                    : "Form No : ${widget.formno}")),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Image.asset(IMAGES.LOGO)),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.44,
                child: boldtext(Colors.blue, 13,
                    "KHYBER WELFARE FORM KARACHI \n DATABASE FORM",
                    center: true)),
            imgicon(context, widget.imgurl, widget.ontap, view: widget.view)
          ],
        )
      ],
    );
  }
}

Widget imgicon(context, String img, VoidCallback ontap, {bool? view}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.25,
    child: Center(
      child: InkWell(
        onTap: ontap,
        child: Stack(
          children: [
            img == null || img == ""
                ? CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.black.withOpacity(0.5),
                    child: const Icon(Icons.person),
                  )
                : CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(img),
                  ),
            view == true
                ? const SizedBox.shrink()
                : Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        // uploadingImage();
                      },
                      child: const CircleAvatar(
                        radius: 10,
                        child: Icon(
                          Icons.edit,
                          color: Colors.black,
                          size: 16,
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    ),
  );
}
