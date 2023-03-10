import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khyberwelfareforum/src/components/network/firebase/collection_names.dart';
import 'package:khyberwelfareforum/src/helpers/color.dart';
import 'package:khyberwelfareforum/src/helpers/const_text.dart';
import 'package:khyberwelfareforum/src/helpers/spacer.dart';

import '../../../components/appbar.dart';
import '../../../components/globals.dart';
import '../../../helpers/alertbox.dart';

class ViewDetailsTreatment extends StatefulWidget {
  const ViewDetailsTreatment({super.key});

  @override
  State<ViewDetailsTreatment> createState() => _ViewDetailsTreatmentState();
}

class _ViewDetailsTreatmentState extends State<ViewDetailsTreatment> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        globalKey: _key,
        title: "View Treatment Details",
        back: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(CollectionNames.TREATMENT)
            .orderBy('date', descending: true)
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
                return SizedBox(
                  child: ListView.builder(
                    itemCount: list.length,
                    shrinkWrap: true,
                    controller: ScrollController(),
                    itemBuilder: (BuildContext context, int index) {
                      List images = list[index]["images"];
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: boldtext(Ccolor.textblack, 14,
                                  "Name Of Hospital : ${list[index]["namehospital"]}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: boldtext(Ccolor.textblack, 14,
                                  "Focal Person Name : ${list[index]["fpname"]}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: boldtext(Ccolor.textblack, 14,
                                  "Focal Person Contact No# :  ${list[index]["fpPhone"]}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: boldtext(Ccolor.textblack, 14,
                                  "Patient Name : ${list[index]["patientName"]}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: boldtext(Ccolor.textblack, 14,
                                  "Patient CNIC : ${list[index]["patientCnic"]}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: boldtext(Ccolor.textblack, 14,
                                  "Patient Contact No# : ${list[index]["patientPhone"]}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: boldtext(Ccolor.textblack, 14,
                                  "Treatment Details : ${list[index]["treatment"]}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: boldtext(Ccolor.textblack, 14,
                                  "Date : ${list[index]["date"]}"),
                            ),
                            vertical(10),
                            list[index]["images"].isEmpty
                                ? const SizedBox.shrink()
                                : SizedBox(
                                    child: ListView.builder(
                                      itemCount: images.length,
                                      shrinkWrap: true,
                                      controller: ScrollController(),
                                      itemBuilder:
                                          (BuildContext context, int index2) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          child: Image.network(
                                              "${images[index2]}"),
                                        );
                                      },
                                    ),
                                  ),
                            vertical(15),
                            (USERROLE == "Admin")
                                ? Align(
                                    alignment: Alignment.bottomRight,
                                    child: IconButton(
                                        onPressed: () async {
                                          showDelete(context, () async {
                                            try {
                                              await FirebaseFirestore.instance
                                                  .collection(
                                                      CollectionNames.TREATMENT)
                                                  .doc(finaldata[index])
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
                            Divider(
                              height: 4,
                              thickness: 4,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
