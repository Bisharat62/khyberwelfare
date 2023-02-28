import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:khyberwelfareforum/src/components/appbar.dart';
import 'package:khyberwelfareforum/src/components/globals.dart';
import 'package:khyberwelfareforum/src/components/network/firebase/collection_names.dart';
import 'package:khyberwelfareforum/src/helpers/color.dart';
import 'package:khyberwelfareforum/src/helpers/const_text.dart';

import '../../../helpers/spacer.dart';

class ViewAllAccountsScreen extends StatefulWidget {
  const ViewAllAccountsScreen({super.key});

  @override
  State<ViewAllAccountsScreen> createState() => _ViewAllAccountsScreenState();
}

class _ViewAllAccountsScreenState extends State<ViewAllAccountsScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        globalKey: _key,
        title: "Accounts",
        back: true,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(CollectionNames.USER)
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
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 1.5, color: Colors.black),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            rowview("Name :", list[index]['name'].toString()),
                            rowview("Email :", list[index]['email'].toString()),
                            rowview("Father's Name :",
                                list[index]['fname'].toString()),
                            rowview("Phone :", list[index]['phone'].toString()),
                            rowview(
                                "Password :", list[index]['pass'].toString()),
                            rowview("Age :", list[index]['age'].toString()),
                            rowview(
                                "Gender :", list[index]['gender'].toString()),
                            rowview("Cnic :", list[index]['cnic'].toString()),
                            rowview(
                                "Address :", list[index]['address'].toString()),
                            rowview("Profession :",
                                list[index]['profession'].toString()),
                            rowview(
                                "Salary :", list[index]['salary'].toString()),
                            rowview("Designation :",
                                list[index]['designation'].toString()),
                            rowview("Dist :", list[index]['dist'].toString()),
                            rowview(
                                "Tehsil :", list[index]['tehsil'].toString()),
                            rowview("UC :", list[index]['uc'].toString()),
                            rowview("Tribe :", list[index]['tribe'].toString()),
                            rowview("Disability :",
                                list[index]['disability'].toString()),
                            rowview("Role :", list[index]['role'].toString()),
                            rowview("Total Database created :",
                                list[index]['addedforms'].toString()),
                            vertical(25),
                            Center(
                                child: IconButton(
                                    onPressed: () async {
                                      try {
                                        await FirebaseFirestore.instance
                                            .collection(CollectionNames.USER)
                                            .doc(finaldata[index])
                                            .delete();
                                      } catch (e) {
                                        print(e.toString());
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.delete_forever,
                                      color: Colors.red,
                                    )))
                          ],
                        ),
                      );
                    },
                  );
                }
            }
          },
        ),
      ),
    );
  }
}

Widget rowview(String text1, String text2) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      children: [
        SizedBox(
          width: totalwidth! * 0.4,
          child: mediumtext(Ccolor.textblack, 14, text1),
        ),
        SizedBox(
            width: totalwidth! * 0.35,
            child: mediumtext(Ccolor.textblack, 14, text2))
      ],
    ),
  );
}
