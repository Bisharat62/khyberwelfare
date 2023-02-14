import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khyberwelfareforum/src/components/globals.dart';
import 'package:khyberwelfareforum/src/components/loader.dart';
import 'package:khyberwelfareforum/src/components/network/chechinternet.dart';
import 'package:khyberwelfareforum/src/components/network/firebase/collection_names.dart';

class FirebaseApi {
  static uploadDatabase(
    context,
    Map<String, dynamic> data,
  ) async {
    loginloader(context);
    try {
      await FirebaseFirestore.instance
          .collection(CollectionNames.DATABASE)
          .doc(DATABASEUID)
          .set(
            data,
          );
      Navigator.pop(context);
      Navigator.pop(context);
      showInSnackBar("Database Created");
    } catch (e) {
      print(e.toString());
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }
}
