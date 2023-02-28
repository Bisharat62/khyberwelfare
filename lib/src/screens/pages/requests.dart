import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khyberwelfareforum/src/helpers/color.dart';
import 'package:khyberwelfareforum/src/helpers/const_text.dart';
import 'package:khyberwelfareforum/src/helpers/spacer.dart';

import '../../components/appbar.dart';
import '../../components/network/firebase/collection_names.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(globalKey: _key, title: "REQUESTS", back: true),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(CollectionNames.HELPREQUEST)
            .orderBy("time", descending: true)
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
                // print(list);
                return ListView.builder(
                  itemCount: list.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Ccolor.texthint),
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: boldtext(Ccolor.textblack, 12,
                                  "${list[index]["request"]}")),
                          vertical(30),
                          boldtext(Ccolor.textblack, 12,
                              "NAME       ${list[index]["name"]}"),
                          vertical(10),
                          boldtext(Ccolor.textblack, 12,
                              "F/NAME     ${list[index]["fname"]}"),
                          vertical(10),
                          boldtext(Ccolor.textblack, 12,
                              "CNIC       ${list[index]["cnic"]}"),
                          vertical(10),
                          boldtext(Ccolor.textblack, 12,
                              "PHONE       ${list[index]["phone"]}"),
                          vertical(10),
                          boldtext(Ccolor.textblack, 12,
                              "ADDRESS    ${list[index]["address"]}"),
                          vertical(10),
                          boldtext(Ccolor.textblack, 12,
                              "COMMENTS   ${list[index]["comments"]}"),
                          vertical(10),
                          list[index]["request"] == "Legal Help"
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    boldtext(Ccolor.textblack, 12,
                                        "FIR NUMBER  ${list[index]["caseno"]}"),
                                    boldtext(Ccolor.textblack, 12,
                                        "YEAR  ${list[index]["year"]}"),
                                    boldtext(Ccolor.textblack, 12,
                                        "POLICE STATION  ${list[index]["policestation"]}"),
                                  ],
                                )
                              : const SizedBox.shrink(),
                          list[index]["request"] == "Medical Help"
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    boldtext(Ccolor.textblack, 12,
                                        "Do You Need Blood   ${list[index]["blood"]} , Blood Group ${list[index]["bloodgroup"]}"),
                                    vertical(10),
                                    boldtext(Ccolor.textblack, 12,
                                        "How Many Bottles   ${list[index]["bottles"]}"),
                                    vertical(10),
                                    boldtext(Ccolor.textblack, 12,
                                        "Which Hospital   ${list[index]["hospital"]}"),
                                    vertical(10),
                                    boldtext(Ccolor.textblack, 12,
                                        "Delivery   ${list[index]["deliver"]}"),
                                  ],
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    );
                  },
                );
              }
          }
        },
      ),
    );
  }
}
