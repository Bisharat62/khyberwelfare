import 'package:flutter/material.dart';

import '../../../../components/assets.dart';
import '../../../../components/globals.dart';
import '../../../../helpers/color.dart';
import '../../../../helpers/const_text.dart';

class AddDatabaseHeader extends StatefulWidget {
  const AddDatabaseHeader({super.key});

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
            child: boldtext(Ccolor.textblack, 10,
                "Form No : ${USEREMAIL!.split("@").first}$ADDEDFORMS")),
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
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.black.withOpacity(0.5),
                      child: const Icon(Icons.person),
                    ),
                    Positioned(
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
          ],
        )
      ],
    );
  }
}
