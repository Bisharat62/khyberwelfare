import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:khyberwelfareforum/src/components/appbar.dart';
import 'package:khyberwelfareforum/src/components/network/firebase/collection_names.dart';
import 'package:khyberwelfareforum/src/screens/pages/controlldonations/add_expenses.dart';

import '../../../helpers/color.dart';
import '../../../helpers/const_text.dart';
import '../../../helpers/spacer.dart';
import 'add_donations.dart';

class ViewExpensesScreen extends StatefulWidget {
  const ViewExpensesScreen({super.key});

  @override
  State<ViewExpensesScreen> createState() => _ViewExpensesScreenState();
}

class _ViewExpensesScreenState extends State<ViewExpensesScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        globalKey: _key,
        title: "View EXPENSES",
        back: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddExpensesScreen()));
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(CollectionNames.EXPENSES)
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
                                  "Donation Amount : ${list[index]["amount"]}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: boldtext(Ccolor.textblack, 14,
                                  "SOURCE : ${list[index]["source"]}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: boldtext(Ccolor.textblack, 14,
                                  "Remarks :  ${list[index]["remarks"]}"),
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
