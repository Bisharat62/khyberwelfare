import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khyberwelfareforum/src/components/network/chechinternet.dart';

import '../loader.dart';

signup(
  context,
  Map<String, dynamic> data,
) async {
  bool internet = false;
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
  if (internet) {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: data['email'], password: data['pass']);
      var uid = await FirebaseAuth.instance.currentUser?.uid;
      addingdata(data, uid!);
    } on FirebaseAuthException catch (e) {
      showInSnackBar(e.message.toString(), color: Colors.red);
      loginloader(context, back: true);
      print(e.code);
    }
  } else {
    print('internet not avaiable');
  }
}

addingdata(Map<String, dynamic> data, String uid) async {
  try {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .set(data)
        .whenComplete(() => print('data uploaded'));
  } catch (e) {
    print(e.toString());
  }
}
