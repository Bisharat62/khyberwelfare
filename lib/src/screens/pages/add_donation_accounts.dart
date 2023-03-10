import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khyberwelfareforum/src/components/network/chechinternet.dart';
import 'package:khyberwelfareforum/src/helpers/button.dart';
import 'package:khyberwelfareforum/src/helpers/spacer.dart';
import 'package:khyberwelfareforum/src/screens/pages/accounts/view_all_accounts.dart';

import '../../components/appbar.dart';
import '../../components/globals.dart';
import '../../helpers/alertbox.dart';
import '../../helpers/color.dart';
import '../../helpers/const_text.dart';
import '../../helpers/text_decor.dart';

class AddDonationAccount extends StatefulWidget {
  const AddDonationAccount({super.key});

  @override
  State<AddDonationAccount> createState() => _AddDonationAccountState();
}

class _AddDonationAccountState extends State<AddDonationAccount> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController accountController = TextEditingController();
  bool isLoading = false;
  bool view = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: boldtext(Colors.black, 12, 'Donation Account'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: buttonmain(() {
              setState(() {
                view = !view;
              });
            }, view ? 'add' : 'view', 0.2, context, fsize: 12, height: 35),
          )
        ],
      ),
      //  Appbar(
      //   globalKey: _key,
      //   title: 'Donation Account',
      //   back: true,
      // ),
      body: view
          ? viewDonationAccounts(view: true)
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  textarea(titleController, 'Account Title'),
                  textarea(detailsController, 'Details'),
                  textarea(accountController, 'Account Number'),
                  vertical(20),
                  isLoading
                      ? const CircularProgressIndicator()
                      : buttonmain(() async {
                          if (accountController.text.isEmpty ||
                              titleController.text.isEmpty ||
                              accountController.text.isEmpty) {
                            showInSnackBar('Please fill All fields',
                                color: Colors.red);
                          } else {
                            setState(() {
                              isLoading = true;
                            });
                            try {
                              await FirebaseFirestore.instance
                                  .collection('donationAccount')
                                  .add({
                                'title': titleController.text,
                                'details': detailsController.text,
                                'number': accountController.text
                              }).then((value) => {
                                        showInSnackBar('Data Saved'),
                                        titleController.clear(),
                                        detailsController.clear(),
                                        accountController.clear(),
                                      });
                            } catch (e) {
                              print(e.toString());
                            }
                            setState(() {
                              isLoading = false;
                            });
                          }
                        }, 'Save', 1, context)
                ],
              ),
            ),
    );
  }

  Widget textarea(TextEditingController controller, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: SizedBox(
        // height: 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            boldtext(Ccolor.texthint, 14, hint),
            SizedBox(
              // height: 40,
              child: TextFormField(
                style: textfieldtextstyle,
                maxLines: hint == 'Details' ? 6 : 1,
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

Widget viewDonationAccounts({bool? view}) {
  return StatefulBuilder(
    builder: (BuildContext context, setState) {
      return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('donationAccount')
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
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListView.builder(
                    controller: ScrollController(),
                    itemCount: list.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        // padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: Ccolor.texthint),
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            rowview1(
                                'Account Title', "${list[index]["title"]}"),
                            rowview1('Details', "${list[index]["details"]}"),
                            rowview1(
                                'Account Number', "${list[index]["number"]}"),
                            vertical(25),
                            (view == true)
                                ? Align(
                                    alignment: Alignment.bottomRight,
                                    child: IconButton(
                                        onPressed: () async {
                                          showDelete(context, () async {
                                            try {
                                              await FirebaseFirestore.instance
                                                  .collection('donationAccount')
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
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
          }
        },
      );
    },
  );
}

Widget rowview1(String text1, String text2) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      children: [
        SizedBox(
          width: totalwidth! * 0.3,
          child: mediumtext(Ccolor.textblack, 12, text1),
        ),
        SizedBox(
            width: totalwidth! * 0.45,
            child: mediumtext(Ccolor.textblack, 12, text2))
      ],
    ),
  );
}
