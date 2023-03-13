import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khyberwelfareforum/src/helpers/button.dart';
import 'package:khyberwelfareforum/src/helpers/color.dart';
import 'package:khyberwelfareforum/src/helpers/const_text.dart';

import '../../../../components/appbar.dart';
import '../../../../components/globals.dart';
import '../../../../helpers/alertbox.dart';
import '../../../../helpers/networkImage.dart';
import '../../../../helpers/spacer.dart';
import '../database_createdbyme.dart';
import '../utils_database/add_database_utils.dart';

class ViewFoodSecurity extends StatefulWidget {
  String title;
  String collectionName;
  ViewFoodSecurity(
      {super.key, required this.title, required this.collectionName});

  @override
  State<ViewFoodSecurity> createState() => _ViewFoodSecurityState();
}

class _ViewFoodSecurityState extends State<ViewFoodSecurity> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        globalKey: _key,
        title: widget.title,
        back: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(widget.collectionName)
            .orderBy('time', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return const Text('Something Went Wrong Try later');
              } else {
                // print(snapshot.data);
                List list = [];
                List finaldata = [];
                list = snapshot.data!.docs
                    .map(
                      (e) => e.data(),
                    )
                    .toList();
                finaldata = snapshot.data!.docs
                    .map(
                      (e) => e.id,
                    )
                    .toList();
                return list.isEmpty
                    ? emptycontainer(context)
                    : Padding(
                        padding: const EdgeInsets.all(10),
                        child: SingleChildScrollView(
                          controller: ScrollController(),
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: buttonmain(() {},
                                  "Total Database ${list.length}", 1, context,
                                  noborder: true),
                            ),
                            ListView.builder(
                              itemCount: list.length,
                              shrinkWrap: true,
                              controller: ScrollController(),
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  padding: const EdgeInsets.all(15),
                                  margin: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        width: 1, color: Colors.grey),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                          alignment: Alignment.bottomRight,
                                          child: imgicon(context,
                                              "${list[index]["ownImg"]}", () {},
                                              view: true)),
                                      boldtext(Ccolor.textblack, 12,
                                          "KWF ID NO   : ${list.length - index}"),
                                      vertical(10),
                                      boldtext(Ccolor.textblack, 12,
                                          "Name   : ${list[index]["name"]}"),
                                      vertical(10),
                                      boldtext(Ccolor.textblack, 12,
                                          "S/O , D/O , W/O   : ${list[index]["elder"]}"),
                                      vertical(10),
                                      boldtext(Ccolor.textblack, 12,
                                          "AGE   : ${list[index]["age"]}"),
                                      vertical(10),
                                      boldtext(Ccolor.textblack, 12,
                                          "Gender   : ${list[index]["gender"]}"),
                                      vertical(10),
                                      boldtext(Ccolor.textblack, 12,
                                          "NAME OF CHILDREEN / SIBLINGS WITH AGE \n   : ${list[index]["childrens"]}"),
                                      vertical(10),
                                      boldtext(Ccolor.textblack, 12,
                                          "CNIC NO OF ${list[index]["cnicOf"]}  : ${list[index]["cnic"]}"),
                                      vertical(10),
                                      boldtext(Ccolor.textblack, 12,
                                          "ADDRESS   : ${list[index]["address"]}"),
                                      vertical(10),
                                      boldtext(Ccolor.textblack, 12,
                                          "DISTRICT / TOWN   : ${list[index]["district"]}"),
                                      vertical(10),
                                      boldtext(Ccolor.textblack, 12,
                                          "CONTACT NO   : ${list[index]["contact"]}"),
                                      vertical(10),
                                      boldtext(Ccolor.textblack, 12,
                                          "SALARY / INCOME   : ${list[index]["salaray"]}"),
                                      vertical(10),
                                      boldtext(Ccolor.textblack, 12,
                                          "ACCOUNT TYPE   : ${list[index]["accounttype"]}"),
                                      vertical(10),
                                      boldtext(Ccolor.textblack, 12,
                                          "ACCOUNT DETAILS   : ${list[index]["accountdetails"]}"),
                                      vertical(10),
                                      boldtext(Ccolor.textblack, 12,
                                          "ACCOUNT NO   : ${list[index]["accountno"]}"),
                                      vertical(10),
                                      boldtext(Ccolor.textblack, 12,
                                          "RESIDENCE   : ${list[index]["residence"]}"),
                                      vertical(10),
                                      boldtext(Ccolor.textblack, 12,
                                          "DESCRIPTION   : ${list[index]["discription"]}"),
                                      vertical(10),
                                      ViewImageNetwork(
                                        imgUrl:
                                            "${list[index]["birthCertificateImg"]}",
                                        text: 'Birth Certificate',
                                      ),
                                      ViewImageNetwork(
                                        imgUrl:
                                            "${list[index]["deathCertificateImg"]}",
                                        text:
                                            'Death Certificate of ${list[index]["deathCertificateOf"]}',
                                      ),
                                      ViewImageNetwork(
                                        imgUrl:
                                            "${list[index]["disablityCertificateImg"]}",
                                        text: 'Disable Certificate',
                                      ),
                                      vertical(30),
                                      const Divider(
                                        thickness: 4,
                                        color: Colors.black,
                                      ),
                                      vertical(20),
                                      boldtext(Ccolor.textblack, 12,
                                          "VERIFIED BY   : ${list[index]["verifiedBy"]}"),
                                      vertical(10),
                                      boldtext(Ccolor.textblack, 12,
                                          "NAME   : ${list[index]["userName"]}"),
                                      vertical(10),
                                      boldtext(Ccolor.textblack, 12,
                                          "CNIC   : ${list[index]["userCnic"]}"),
                                      vertical(10),
                                      boldtext(Ccolor.textblack, 12,
                                          "DESIGNATION   : ${list[index]["designation"]}"),
                                      vertical(10),
                                      boldtext(Ccolor.textblack, 12,
                                          "CONTACT NO   : ${list[index]["userContact"]}"),
                                      vertical(30),
                                      (USERROLE == "Admin")
                                          ? Align(
                                              alignment: Alignment.bottomRight,
                                              child: IconButton(
                                                  onPressed: () async {
                                                    showDelete(context,
                                                        () async {
                                                      try {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(widget
                                                                .collectionName)
                                                            .doc(finaldata[
                                                                index])
                                                            .delete();
                                                      } catch (e) {
                                                        print(e.toString());
                                                      }
                                                      Navigator.pop(context);
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons.delete_forever,
                                                    color: Colors.red,
                                                  )))
                                          : const SizedBox.shrink(),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ]),
                        ),
                      );
              }
          }
        },
      ),
    );
  }
}
