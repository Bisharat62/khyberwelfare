import 'package:flutter/material.dart';
import 'package:khyberwelfareforum/src/helpers/spacer.dart';
import 'package:khyberwelfareforum/src/screens/authentication/signin.dart';
import 'package:khyberwelfareforum/src/screens/pages/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/color.dart';
import '../helpers/const_text.dart';

class DrawerMain extends StatelessWidget {
  const DrawerMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          vertical(80),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomepageScreen()));
            },
            leading: boldtext(Ccolor.textblack, 14, 'Home'),
          ),
          ListTile(
            onTap: () {
              delete_saved_login();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignInScreen()));
            },
            leading: boldtext(Ccolor.textblack, 14, 'Logout'),
          ),
        ],
      ),
    );
  }
}

delete_saved_login() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.clear();
}
