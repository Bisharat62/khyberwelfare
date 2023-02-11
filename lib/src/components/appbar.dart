import 'package:flutter/material.dart';

import '../helpers/color.dart';
import '../helpers/const_text.dart';

class Appbar extends StatelessWidget with PreferredSizeWidget {
  GlobalKey<ScaffoldState> globalKey;
  String title;
  bool? back;
  Appbar({super.key, required this.globalKey, required this.title, this.back});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Ccolor.btnbg,
      title: boldtext(Ccolor.textblack, 14, title),
      centerTitle: true,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: (back == true)
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black,
              ))
          : IconButton(
              onPressed: () {
                globalKey.currentState!.openDrawer();
              },
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              )),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(40);
}
