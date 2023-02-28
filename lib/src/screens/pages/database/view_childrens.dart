import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khyberwelfareforum/src/components/globals.dart';
import 'package:khyberwelfareforum/src/helpers/color.dart';
import 'package:khyberwelfareforum/src/helpers/const_text.dart';

import '../../../components/network/firebase/collection_names.dart';
import '../../../helpers/spacer.dart';
import 'utils_database/add_database_utils.dart';

class ViewChildrensWidget extends StatefulWidget {
  String docid;
  ViewChildrensWidget({super.key, required this.docid});

  @override
  State<ViewChildrensWidget> createState() => _ViewChildrensWidgetState();
}

class _ViewChildrensWidgetState extends State<ViewChildrensWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(
              "${CollectionNames.DATABASE}/${widget.docid}/${CollectionNames.CHILDREEN}")
          .orderBy('time', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: SizedBox.shrink());
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
              print(list.length);
              return ListView.builder(
                itemCount: list.length,
                shrinkWrap: true,
                controller: ScrollController(),
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      imgicon(
                          context,
                          list[index]['cimgurl'] == null ||
                                  list[index]['cimgurl'] == ""
                              ? ""
                              : list[index]['cimgurl'].toString(),
                          () {},
                          view: true),
                      boldtext(Ccolor.texthint, 10,
                          "NAME : ${list[index]['name']} GENDER : ${list[index]['gender']} AGE : ${list[index]['age']} Birth Certificate : ${list[index]['birthcertificate']}"),
                      boldtext(Ccolor.texthint, 10,
                          "CNIC : ${list[index]['cnic']} SPORTS : ${list[index]['sports']} EDUCATION : ${list[index]['education']}  TECHNICAL SKILLS : ${list[index]['skills']} IT COURSE : ${list[index]['itcource']}"),
                      boldtext(Ccolor.texthint, 10,
                          "JOB : ${list[index]['job']} DRUG ADDICTED : ${list[index]['drug']}  DISABILITY: ${list[index]['disability']} "),
                      vertical(10)
                    ],
                  );
                },
              );
            }
        }
      },
    );
  }
}
