import 'package:flutter/material.dart';

import '../helpers/color.dart';
import '../helpers/const_text.dart';

class Appbar extends StatelessWidget with PreferredSizeWidget {
  String title;
  Appbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Ccolor.btnbg,
      title: boldtext(Ccolor.textblack, 14, title),
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          )),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
