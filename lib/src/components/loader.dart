import 'package:flutter/material.dart';

loginloader(context, {bool? back}) {
  if (back == true) {
    Navigator.pop(context);
  } else {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => const AlertDialog(
        backgroundColor: Colors.transparent,
        content: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.transparent,
          child: CircularProgressIndicator(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
