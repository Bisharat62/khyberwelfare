import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khyberwelfareforum/src/components/appbar.dart';
import 'package:khyberwelfareforum/src/components/network/firebase/collection_names.dart';
import 'package:khyberwelfareforum/src/helpers/color.dart';
import 'package:khyberwelfareforum/src/helpers/const_text.dart';
import 'package:khyberwelfareforum/src/screens/pages/database/detailed_database.dart';

import 'database_createdbyme.dart';

class ViewDatabaseScreen extends StatefulWidget {
  const ViewDatabaseScreen({super.key});

  @override
  State<ViewDatabaseScreen> createState() => _ViewDatabaseScreenState();
}

class _ViewDatabaseScreenState extends State<ViewDatabaseScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        globalKey: _key,
        title: "View Database",
        back: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(CollectionNames.DATABASE)
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
                // print("finaldata : $finaldata");
                // print(list);
                return list.isEmpty
                    ? emptycontainer(context)
                    : ListView.builder(
                        itemCount: list.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return list[index]['name'].toString == "empty" ||
                                  list[index]['name'].toString == "" ||
                                  list[index]['name'].toString == null
                              ? const SizedBox.shrink()
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          boldtext(Ccolor.textblack, 12,
                                              "FormNO : ${list[index]['formno']}"),
                                          boldtext(Ccolor.textblack, 12,
                                              "CreatedBY : ${list[index]['createdby']}"),
                                        ],
                                      ),
                                      ListTile(
                                        leading: CircleAvatar(
                                          radius: 30,
                                          backgroundImage: NetworkImage(
                                              "${list[index]['imgurl']}"),
                                        ),
                                        title: mediumtext(Ccolor.textblack, 12,
                                            "NAME : ${list[index]["name"]} , F/Name : ${list[index]["fname"]}"),
                                        subtitle: mediumtext(
                                            Ccolor.textblack,
                                            12,
                                            "CNIC# : ${list[index]["cnic"]} "),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailedDatabase(
                                                          data: list[index],
                                                          docid: finaldata[
                                                              index])));
                                        },
                                      )
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
