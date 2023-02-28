import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khyberwelfareforum/src/components/globals.dart';
import 'package:khyberwelfareforum/src/components/network/firebase/collection_names.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../screens/pages/homepage.dart';
import '../loader.dart';
import 'chechinternet.dart';

signin(context, Map data) async {
  bool? login;
  bool? internet;
  loginloader(context);
  try {
    final result = await InternetAddress.lookup('www.google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      internet = true;
    }
  } on SocketException catch (_) {
    showInSnackBar('No Internet', color: Colors.red);
    loginloader(context, back: true);
  }
  if (internet == true) {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: data["email"], password: data["pass"]);
      USERUID = FirebaseAuth.instance.currentUser?.uid;
      login = true;
    } on FirebaseException catch (e) {
      showInSnackBar(e.message.toString(), color: Colors.red);
      loginloader(context, back: true);
    }
  }
  if (login == true) {
    print(USERUID);
    try {
      await FirebaseFirestore.instance
          .collection(CollectionNames.USER)
          .doc(USERUID)
          .get()
          .then((value) => {
                USERROLE = value.data()!["role"],
                USEREMAIL = value.data()!["email"],
                ADDEDFORMS = value.data()!["addedforms"],
                distName = value.data()!["dist"]
              });
      if (USEREMAIL != null) {
        savedata();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomepageScreen()));
      } else {
        showInSnackBar("No User Record Found", color: Colors.red);
        loginloader(context, back: true);
      }
    } catch (e) {
      print(e.toString());

      showInSnackBar("No User Record Found", color: Colors.red);
      loginloader(context, back: true);
    }
  }
}

savedata() async {
  // print("saving data");
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.setStringList(
      "data", [USERROLE.toString(), USEREMAIL.toString(), USERUID.toString()]);
  _prefs.setInt("addedforms", ADDEDFORMS!);
  _prefs.setString("dist", distName!);

  // print(_prefs.getStringList("data"));
}
