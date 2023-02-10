import 'dart:io';

import 'package:flutter/material.dart';

import '../loader.dart';

checkinternet(context, {bool? again, bool? loader, bool? noSnacbar}) async {
  if (loader == true) {
    loginloader(context);
  }
  try {
    final result = await InternetAddress.lookup('www.google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected------------------------');
      if (again == true) {
        showInSnackBar(
          'Online',
        );
      }
      if (loader == true) {
        loginloader(context, back: true);
      }
    }
  } on SocketException catch (_) {
    print('not connected');
    if (noSnacbar == true) {
    } else {
      showInSnackBar('No Internet', color: Colors.red);
    }

    if (loader == true) {
      loginloader(context, back: true);
    }
    await Future.delayed(
        const Duration(
          seconds: 20,
        ), (() {
      checkinternet(again: true, context);
    }));
  }
}

GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();
double? totalheight;

void showInSnackBar(String value, {Color? color}) {
  final SnackBar snackBar = SnackBar(
    content: Text(
      value,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    ),
    backgroundColor: color ?? Colors.green,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
    // margin: EdgeInsets.only(bottom: totalheight! - 85, right: 20, left: 20),
  );

  snackbarKey.currentState?.showSnackBar(snackBar);
}
