import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:khyberwelfareforum/src/components/globals.dart';
import 'package:khyberwelfareforum/src/components/loader.dart';
import 'package:khyberwelfareforum/src/components/network/chechinternet.dart';
import 'package:khyberwelfareforum/src/components/network/firebase/collection_names.dart';
import 'package:khyberwelfareforum/src/screens/authentication/signin.dart';

import '../../drawer.dart';

class FirebaseApi {
  static uploadDatabase(
    context,
    Map<String, dynamic> data,
  ) async {
    loginloader(context);
    // try {
    //   data['serialno'] = await FirebaseFirestore.instance
    //       .collection(CollectionNames.DATABASE)
    //       .snapshots()
    //       .length;
    // } catch (e) {
    //   print(e.toString());
    // }

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

  static uploadFoodSecurity(
      context, Map<String, dynamic> data, String colName) async {
    loginloader(context);
    // try {
    //   data['serialno'] = await FirebaseFirestore.instance
    //       .collection(CollectionNames.DATABASE)
    //       .snapshots()
    //       .length;
    // } catch (e) {
    //   print(e.toString());
    // }

    try {
      await FirebaseFirestore.instance.collection(colName).add(
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

  static helprequest(Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance
          .collection(CollectionNames.HELPREQUEST)
          .add(data)
          .whenComplete(() => print("help submitted"));
    } catch (e) {
      print(e.toString());
    }
  }

  static updatepass(context, String oldpass, String newpass) async {
    bool? oldPass;
    loginloader(context);
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: USEREMAIL.toString(), password: oldpass)
          .then((value) => {
                oldPass = true,
              });
    } catch (e) {
      loginloader(context, back: true);
      showInSnackBar("Old Password Is Incorrect", color: Colors.red);
      print(e.toString());
    }
    if (oldPass == true) {
      try {
        await FirebaseAuth.instance.currentUser!
            .updatePassword(newpass)
            .then((value) => {
                  showInSnackBar(
                    "Password Is Changed",
                  ),
                  delete_saved_login(),
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInScreen()))
                });
        updateondatabase(newpass);
      } catch (e) {
        loginloader(context, back: true);
      }
    }
  }
}

void updateondatabase(String pass) async {
  try {
    await FirebaseFirestore.instance
        .collection(CollectionNames.USER)
        .doc(USERUID)
        .update({"pass": pass}).then((value) => print("updated on firestore"));
  } catch (e) {
    print(e.toString());
  }
}

checking(context, String cnic, String collection) async {
  bool? exist;
  print(cnic);
  loginloader(context);
  print('inside checking');
  try {
    await FirebaseFirestore.instance
        .collection(collection)
        .where('cnic', isEqualTo: cnic)
        .get()
        .then((value) => {
              if (value.docs.isNotEmpty)
                {
                  exist = true,
                  showInSnackBar('CNIC already exist in database',
                      color: Colors.red)
                },
              print(value.docs.length)
              // {

              // }
            });

    Navigator.pop(context);
  } catch (e) {
    Navigator.pop(context);
    print(e.toString());
  }
  print(exist);
  return exist ?? false;
}
