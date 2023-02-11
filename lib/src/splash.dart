import 'dart:async';

import 'package:flutter/material.dart';
import 'package:khyberwelfareforum/src/components/assets.dart';
import 'package:khyberwelfareforum/src/components/globals.dart';
import 'package:khyberwelfareforum/src/helpers/color.dart';
import 'package:khyberwelfareforum/src/screens/authentication/signin.dart';
import 'package:khyberwelfareforum/src/screens/pages/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<String> values = [];
  getvalues() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (_prefs.getStringList("data") != null) {
      setState(() {
        values = _prefs.getStringList("data")!;
        USERROLE = values[0];
        USEREMAIL = values[1];
        USERUID = values[2];
        ADDEDFORMS = _prefs.getString("addedforms");
      });
    }
  }

  navigator() {
    Timer(const Duration(seconds: 5), () {
      // if (index == 0) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => values.isNotEmpty
                  ? const HomepageScreen()
                  : const SignInScreen()));
      // } else {
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigator();
    getvalues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Ccolor.btnbg,
      body: Center(child: Image.asset(IMAGES.LOGO)),
    );
  }
}
