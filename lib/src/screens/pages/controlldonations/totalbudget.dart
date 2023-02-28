import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khyberwelfareforum/src/components/network/firebase/collection_names.dart';
import 'package:khyberwelfareforum/src/helpers/button.dart';
import 'package:khyberwelfareforum/src/helpers/color.dart';
import 'package:khyberwelfareforum/src/helpers/const_text.dart';
import 'package:khyberwelfareforum/src/helpers/spacer.dart';

import '../../../components/appbar.dart';

class TotalBudget extends StatefulWidget {
  const TotalBudget({super.key});

  @override
  State<TotalBudget> createState() => _TotalBudgetState();
}

class _TotalBudgetState extends State<TotalBudget> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  String month = '${parts[0]}-${parts[1]}';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        globalKey: _key,
        title: "Total Budget",
        back: true,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                boldtext(Ccolor.textblack, 14, month),
                horizental(50),
                buttonmain(() {
                  showbottom();
                }, "Change Date", 0.3, context, fsize: 12, height: 35)
              ],
            ),
            vertical(30),
            donationsum(month),
            vertical(30),
            expensessum(month),
          ],
        ),
      ),
    );
  }

  showbottom() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            children: [
              Container(
                child: SizedBox(
                  height: 200,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: DateTime(2023, 1, 1),
                    onDateTimeChanged: (DateTime newDateTime) {
                      List<String> dateParts =
                          newDateTime.toString().split("-");
                      print(dateParts[0]);
                      print(dateParts[1]);
                      this.setState(() {
                        month = "${dateParts[0]}-${dateParts[1]}";
                      });
                    },
                  ),
                ),
              ),
              buttonmain(() {
                Navigator.pop(context);
              }, "Select", 0.5, context, fsize: 12, height: 35)
            ],
          );
        });
  }
}

Widget donationsum(String month) {
  return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection(CollectionNames.DONATIONS)
        .where("month", isEqualTo: month)
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
            int? total = 0;
            List list = [];
            list = snapshot.data!.docs
                .map(
                  (e) => e.data()['amount'],
                )
                .toList();
            print(list);
            for (var i = 0; i < list.length; i++) {
              total = (total! + list[i]) as int?;
            }
            print(total);
            return Container(
                width: 250,
                height: 150,
                decoration: BoxDecoration(
                    color: Ccolor.btnbg,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    boldtext(Ccolor.textblack, 16, "Expenditure"),
                    vertical(10),
                    boldtext(Ccolor.textblack, 16, "$total"),
                  ],
                ));
          }
      }
    },
  );
}

Widget expensessum(String month) {
  return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection(CollectionNames.EXPENSES)
        .where("month", isEqualTo: month)
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
            int? total = 0;
            List list = [];
            list = snapshot.data!.docs
                .map(
                  (e) => e.data()['amount'],
                )
                .toList();
            print(list);
            for (var i = 0; i < list.length; i++) {
              total = (total! + list[i]) as int?;
            }
            print(total);
            return Container(
                width: 250,
                height: 150,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    boldtext(Ccolor.textblack, 16, "Funds Received"),
                    vertical(10),
                    boldtext(Ccolor.textblack, 16, "$total"),
                  ],
                ));
          }
      }
    },
  );
}

List<String> parts = DateTime.now().toString().split("-");
