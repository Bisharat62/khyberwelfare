// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khyberwelfareforum/src/components/appbar.dart';
import 'package:khyberwelfareforum/src/components/loader.dart';
import 'package:khyberwelfareforum/src/components/network/chechinternet.dart';
import 'package:khyberwelfareforum/src/components/network/firebase/collection_names.dart';
import 'package:khyberwelfareforum/src/helpers/color.dart';
import 'package:khyberwelfareforum/src/helpers/const_text.dart';
import 'package:khyberwelfareforum/src/helpers/spacer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/network/lists.dart';
import '../../../helpers/button.dart';
import '../../../helpers/text_decor.dart';

class AddDetailsCimmiteeMembers extends StatefulWidget {
  String title;
  AddDetailsCimmiteeMembers({
    super.key,
    required this.title,
  });

  @override
  State<AddDetailsCimmiteeMembers> createState() =>
      _AddDetailsCimmiteeMembersState();
}

class _AddDetailsCimmiteeMembersState extends State<AddDetailsCimmiteeMembers> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Appbar(
          globalKey: _key,
          title: widget.title,
          back: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showbottom();
          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: viewCommiteNumbers(context, widget.title)
        //  StreamBuilder(
        //   stream: FirebaseFirestore.instance
        //       .collection(CollectionNames.COMMITEE_NUMBERS)
        //       .where("committee", isEqualTo: widget.title)
        //       .snapshots(),
        //   builder: (BuildContext context, AsyncSnapshot snapshot) {
        //     switch (snapshot.connectionState) {
        //       case ConnectionState.waiting:
        //         return const Center(child: CircularProgressIndicator());
        //       default:
        //         if (snapshot.hasError) {
        //           return const Text('Something Went Wrong Try later');
        //         } else {
        //           // print(snapshot.data);
        //           List list = [];
        //           List finaldata = [];
        //           list = snapshot.data!.docs
        //               .map(
        //                 (e) => e.data(),
        //               )
        //               .toList();
        //           finaldata = snapshot.data!.docs
        //               .map(
        //                 (e) => e.id,
        //               )
        //               .toList();

        //           // "committee": widget.title,
        //           // "phone": phone.text,
        //           // "name": name.text,
        //           // "designation": designation.text
        //           return list.isEmpty
        //               ? Center(
        //                   child:
        //                       boldtext(Ccolor.textblack, 14, "No Data Available"))
        //               : ListView.builder(
        //                   itemCount: list.length,
        //                   itemBuilder: (BuildContext context, int index) {
        //                     return Padding(
        //                       padding: const EdgeInsets.symmetric(vertical: 10),
        //                       child: ListTile(
        //                         trailing: IconButton(
        //                             onPressed: () async {
        //                               try {
        //                                 await FirebaseFirestore.instance
        //                                     .collection(
        //                                         CollectionNames.COMMITEE_NUMBERS)
        //                                     .doc(finaldata[index])
        //                                     .delete();
        //                               } catch (e) {
        //                                 print(e.toString());
        //                               }
        //                             },
        //                             icon: Icon(
        //                               Icons.delete,
        //                               color: Colors.red,
        //                             )),
        //                         title: boldtext(Ccolor.textblack, 12,
        //                             "${list[index]["designation"]}"),
        //                         subtitle: Column(
        //                           crossAxisAlignment: CrossAxisAlignment.start,
        //                           children: [
        //                             boldtext(Ccolor.texthint, 12,
        //                                 "NAME : ${list[index]["name"]}"),
        //                             boldtext(Ccolor.texthint, 12,
        //                                 "PHONE : ${list[index]["phone"]}"),
        //                             vertical(10),
        //                             const Divider(
        //                               height: 1,
        //                               color: Colors.black,
        //                             )
        //                           ],
        //                         ),
        //                       ),
        //                     );
        //                   },
        //                 );
        //         }
        //     }
        //   },
        // ),
        );
  }

  showbottom() {
    TextEditingController designation = TextEditingController();
    TextEditingController name = TextEditingController();
    TextEditingController phone = TextEditingController();
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.9,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close)),
                    ),
                    vertical(30),
                    boldtext(Ccolor.btnbg, 12, "Add Details"),
                    vertical(20),
                    textarea(designation, "DESIGNATION"),
                    textarea(name, "NAME"),
                    textarea(phone, "NUMBER"),
                    vertical(39),
                    buttonmain(() async {
                      if (name.text.isEmpty ||
                          designation.text.isEmpty ||
                          phone.text.isEmpty) {
                      } else {
                        loginloader(context);
                        try {
                          await FirebaseFirestore.instance
                              .collection(CollectionNames.COMMITEE_NUMBERS)
                              .add({
                            "committee": widget.title,
                            "phone": phone.text,
                            "name": name.text,
                            "designation": designation.text
                          }).then((value) => print("added"));
                          loginloader(context, back: true);
                          Navigator.pop(context);
                          showInSnackBar("Values Added");
                        } catch (e) {
                          print(e.toString());
                          loginloader(context, back: true);
                          Navigator.pop(context);
                          showInSnackBar("Error Occured Try Again",
                              color: Colors.red);
                        }
                      }
                    }, "SAVE", 0.5, context, fsize: 12, height: 35),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget textarea(TextEditingController controller, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: SizedBox(
        height: 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            boldtext(Ccolor.texthint, 14, hint),
            SizedBox(
              height: 40,
              child: TextFormField(
                style: textfieldtextstyle,
                controller: controller,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 25),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Ccolor.texthint)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Ccolor.texthint)),
                    fillColor: Ccolor.textwhite),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget viewCommiteNumbers(context, String title, {bool? call}) {
  return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection(CollectionNames.COMMITEE_NUMBERS)
        .where("committee", isEqualTo: title)
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

            // "committee": widget.title,
            // "phone": phone.text,
            // "name": name.text,
            // "designation": designation.text
            return list.isEmpty
                ? Center(
                    child: boldtext(Ccolor.textblack, 14, "No Data Available"))
                : ListView.builder(
                    itemCount: list.length,
                    controller: ScrollController(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          trailing: call == true
                              ? IconButton(
                                  onPressed: () {
                                    _launchCaller("${list[index]["phone"]}");
                                  },
                                  icon: const Icon(
                                    Icons.call,
                                    size: 30,
                                    color: Colors.green,
                                  ))
                              : IconButton(
                                  onPressed: () async {
                                    try {
                                      await FirebaseFirestore.instance
                                          .collection(
                                              CollectionNames.COMMITEE_NUMBERS)
                                          .doc(finaldata[index])
                                          .delete();
                                    } catch (e) {
                                      print(e.toString());
                                    }
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )),
                          title: Center(
                            child: boldtext(Ccolor.textblack, 12,
                                "${list[index]["designation"].toString().toUpperCase()}"),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              boldtext(Ccolor.texthint, 12,
                                  "NAME : ${list[index]["name"]}"),
                              boldtext(Ccolor.texthint, 12,
                                  "PHONE : ${list[index]["phone"]}"),
                              vertical(10),
                              const Divider(
                                height: 2,
                                color: Colors.black,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
          }
      }
    },
  );
}

_launchCaller(String num) async {
  final url = "tel:$num";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
