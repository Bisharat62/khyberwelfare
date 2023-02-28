import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khyberwelfareforum/src/components/globals.dart';
import 'package:khyberwelfareforum/src/components/loader.dart';
import 'package:khyberwelfareforum/src/components/network/chechinternet.dart';
import 'package:khyberwelfareforum/src/components/network/firebase/collection_names.dart';
import 'package:khyberwelfareforum/src/helpers/button.dart';
import 'package:khyberwelfareforum/src/helpers/color.dart';
import 'package:khyberwelfareforum/src/helpers/const_text.dart';
import 'package:khyberwelfareforum/src/helpers/spacer.dart';

import '../../../components/network/lists.dart';
import '../../../helpers/text_decor.dart';
import '../../authentication/signup.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController fname = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController salary = TextEditingController();
  TextEditingController profession = TextEditingController();
  TextEditingController tribe = TextEditingController();
  TextEditingController dist = TextEditingController();
  TextEditingController tehsil = TextEditingController();
  TextEditingController uc = TextEditingController();
  TextEditingController age = TextEditingController();
  bool viewOnly = true;
  int distindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Ccolor.btnbg,
        title: boldtext(Ccolor.textblack, 12, "Profile"),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                setState(() {
                  viewOnly = false;
                });
              },
              child: boldtext(Ccolor.texthint, 13, "EDIT"))
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(CollectionNames.USER)
            .doc(USERUID)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return const Text('Something Went Wrong Try later');
              } else {
                if (dist.text.isEmpty) {
                  name.text = snapshot.data["name"];
                  fname.text = snapshot.data["fname"];
                  phone.text = snapshot.data["phone"];
                  salary.text = snapshot.data["salary"];
                  profession.text = snapshot.data["profession"];
                  tribe.text = snapshot.data["tribe"];
                  dist.text = snapshot.data["dist"];
                  tehsil.text = snapshot.data["tehsil"];
                  uc.text = snapshot.data["uc"];
                  age.text = snapshot.data["age"];
                }
                print(snapshot.data["name"]);
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        vertical(40),
                        textarea(name, "Name"),
                        textarea(fname, "Father's Name"),
                        textarea(phone, "Phone"),
                        textarea(age, "Age"),
                        textarea(profession, "Profession"),
                        viewOnly
                            ? textarea(salary, "Salary")
                            : Row(
                                children: [
                                  checkboxcard(() {
                                    setState(() {
                                      salary.text = "<30";
                                    });
                                  }, salary.text == "<30", "<30"),
                                  checkboxcard(() {
                                    setState(() {
                                      salary.text = "<60";
                                    });
                                  }, salary.text == "<60", "<60"),
                                  checkboxcard(() {
                                    setState(() {
                                      salary.text = "<90";
                                    });
                                  }, salary.text == "<90", "<90"),
                                  checkboxcard(() {
                                    setState(() {
                                      salary.text = ">90";
                                    });
                                  }, salary.text == ">90", ">90"),
                                  checkboxcard(() {
                                    setState(() {
                                      salary.text = "Jobless";
                                    });
                                  }, salary.text == "Jobless", "Jobless"),
                                ],
                              ),
                        textarea(tribe, "Tribe"),
                        textarea(dist, "Dist"),
                        textarea(tehsil, "Tehsil"),
                        textarea(uc, "UC"),
                        vertical(60),
                        Center(
                            child: viewOnly
                                ? const SizedBox.shrink()
                                : buttonmain(() async {
                                    loginloader(context);
                                    try {
                                      await FirebaseFirestore.instance
                                          .collection(CollectionNames.USER)
                                          .doc(USERUID)
                                          .update({
                                        "name": name.text,
                                        "fname": fname.text,
                                        "phone": phone.text,
                                        "salary": salary.text,
                                        "profession": profession.text,
                                        "tribe": tribe.text,
                                        "dist": dist.text,
                                        "tehsil": tehsil.text,
                                        "uc": uc.text,
                                        "age": age.text
                                      }).then((value) => {
                                                setState(() {
                                                  viewOnly = true;
                                                }),
                                                loginloader(context,
                                                    back: true),
                                                showInSnackBar("Data Updated"),
                                              });
                                    } catch (e) {
                                      loginloader(context, back: true);
                                      showInSnackBar("Error Occured Try Again",
                                          color: Colors.red);
                                    }

                                    dist.clear();
                                  }, "UPDATE", 0.7, context,
                                    fsize: 12, height: 35)),
                        vertical(30),
                      ],
                    ),
                  ),
                );
              }
          }
        },
      ),
    );
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
                readOnly: hint == "Dist" || hint == "Tehsil" ? true : viewOnly,
                onTap: () {
                  if (hint == "Dist") {
                    showbottom(controller, distnames, number: distindex);
                  } else if (hint == "Tehsil") {
                    showbottom(controller, town[distindex]);
                  }
                },
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

  showbottom(TextEditingController _controller, List data, {int? number}) {
    showModalBottomSheet(
        backgroundColor: Colors.black.withOpacity(0.3),
        barrierColor: Colors.black.withOpacity(0.9),
        context: context,
        builder: (context) {
          return Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Colors.white),
            child: StatefulBuilder(
              builder: (BuildContext context, setState) {
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: boldtext(Ccolor.textblack, 12, data[index]),
                      onTap: () {
                        this.setState(
                          () {
                            _controller.text = data[index];
                            if (number != null) {
                              distindex = index;
                            }
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          );
        });
  }
}
