import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:khyberwelfareforum/src/components/appbar.dart';
import 'package:khyberwelfareforum/src/components/globals.dart';
import 'package:khyberwelfareforum/src/components/network/firebase/collection_names.dart';
import 'package:khyberwelfareforum/src/helpers/button.dart';
import 'package:khyberwelfareforum/src/helpers/color.dart';
import 'package:khyberwelfareforum/src/helpers/const_text.dart';
import 'package:khyberwelfareforum/src/helpers/spacer.dart';
import 'package:khyberwelfareforum/src/screens/pages/database/utils_database/add_database_utils.dart';

import '../../../helpers/text_decor.dart';
import '../../authentication/signup.dart';

class DatabaseAddScreen extends StatefulWidget {
  const DatabaseAddScreen({super.key});

  @override
  State<DatabaseAddScreen> createState() => _DatabaseAddScreenState();
}

class _DatabaseAddScreenState extends State<DatabaseAddScreen> {
  create() async {
    try {
      await FirebaseFirestore.instance
          .collection(CollectionNames.DATABASE)
          .add({"time": DateTime.now().toString()})
          .then((value) => {
                print(value.id),
                DATABASEUID = value.id,
              })
          .then((value) => {
                setState(() {
                  child = true;
                })
              });
    } catch (e) {
      print(e.toString());
    }
  }

  bool child = false;
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  TextEditingController name = TextEditingController();
  TextEditingController fname = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController education = TextEditingController();
  TextEditingController course = TextEditingController();
  TextEditingController experiance = TextEditingController();
  TextEditingController cnic = TextEditingController();
  TextEditingController job = TextEditingController();
  bool searchjob = false;
  bool onjob = false;

  TextEditingController salary = TextEditingController();
  bool less30 = false;
  bool less60 = false;
  bool less90 = false;
  bool jobless = false;
  TextEditingController maritalstatus = TextEditingController();
  bool yes = false;
  bool no = false;
  TextEditingController house = TextEditingController();
  bool own = false;
  bool rent = false;
  TextEditingController address = TextEditingController();
  TextEditingController details = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    create();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        globalKey: _key,
        title: "Add Database",
        back: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AddDatabaseHeader(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textarea(name, "NAME", 0.4),
                  textarea(fname, "F/NAME", 0.4),
                ],
              ),
              vertical(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textarea(phone, "CONTACT", 0.3),
                  textarea(age, "AGE", 0.25),
                  textarea(education, "EDUCATION", 0.3),
                ],
              ),
              vertical(15),
              textarea(course, "ANY TECHNICAL/COMPUTER COURSE", 0.9),
              vertical(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textarea(experiance, "EXPERIANCE", 0.4),
                  textarea(cnic, "CNIC#", 0.4),
                ],
              ),
              vertical(15),
              Row(
                children: [
                  textarea(job, "JOB", 0.3),
                  checkboxcard(() {
                    setState(() {
                      onjob = false;
                      searchjob = true;
                    });
                  }, searchjob, "SEARCHING JOB", fsize: 10),
                  checkboxcard(() {
                    setState(() {
                      onjob = true;
                      searchjob = false;
                    });
                  }, onjob, "ON JOB", fsize: 10),
                ],
              ),
              vertical(10),
              boldtext(Ccolor.texthint, 14, "Salary"),
              vertical(10),
              Row(
                children: [
                  checkboxcard(() {
                    setState(() {
                      less30 = true;
                      less60 = false;
                      less90 = false;
                      jobless = false;
                      salary.text = "<30";
                    });
                  }, less30, "<30"),
                  checkboxcard(() {
                    setState(() {
                      less30 = false;
                      less60 = true;
                      less90 = false;
                      jobless = false;
                      salary.text = "<60";
                    });
                  }, less60, "<60"),
                  checkboxcard(() {
                    setState(() {
                      less30 = false;
                      less60 = false;
                      less90 = true;
                      jobless = false;
                      salary.text = "<90";
                    });
                  }, less90, "<90"),
                  checkboxcard(() {
                    setState(() {
                      less30 = false;
                      less60 = false;
                      less90 = false;
                      jobless = true;
                      salary.text = "Jobless";
                    });
                  }, jobless, "JOBLESS"),
                ],
              ),
              vertical(15),
              Row(
                children: [
                  boldtext(Ccolor.texthint, 14, "MARITAL STATUS"),
                  checkboxcard(
                    () {
                      setState(() {
                        yes = true;
                        no = false;
                        maritalstatus.text = "yes";
                      });
                    },
                    yes,
                    "YES",
                  ),
                  checkboxcard(() {
                    setState(() {
                      no = true;
                      yes = false;
                      maritalstatus.text = "no";
                    });
                  }, no, "NO"),
                ],
              ),
              vertical(15),
              Row(
                children: [
                  boldtext(Ccolor.texthint, 14, "HOUSE"),
                  checkboxcard(() {
                    setState(() {
                      own = true;
                      rent = false;
                      house.text = "OWN";
                    });
                  }, own, "OWN"),
                  checkboxcard(() {
                    setState(() {
                      own = false;
                      rent = true;
                      house.text = "rent  ";
                    });
                  }, rent, "RENT"),
                  rent == true
                      ? textarea(house, "RENT AMOUNT", 0.25)
                      : const SizedBox.shrink()
                ],
              ),
              vertical(15),
              boldtext(Ccolor.texthint, 12, "CHILDREN"),
              Center(
                child: buttonmain(() {
                  addchild(context);
                }, "ADD CHILD", 0.5, context, height: 35, fsize: 12),
              ),
              vertical(15),
              textarea(address, "ADDRESS", 0.9),
              vertical(15),
              boldtext(Ccolor.texthint, 12,
                  "ANY CHRONIC AILMENT TO ANY FAMILY MEMBER"),
              textarea(details, "DETAILS", 0.9)
            ],
          ),
        ),
      ),
    );
  }

  Widget textarea(TextEditingController controller, String hint, double width) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width * width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            boldtext(Ccolor.texthint, 14, hint),
            SizedBox(
              height: 30,
              child: TextFormField(
                style: textfieldtextstyle,
                controller: controller,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 25),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Ccolor.texthint)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Ccolor.texthint)),
                    fillColor: Ccolor.textwhite),
              ),
            ),
          ],
        ),
      ),
    );
  }

  addchild(context) {
    final TextEditingController name = TextEditingController();
    final TextEditingController gender = TextEditingController();
    final TextEditingController age = TextEditingController();
    final TextEditingController school = TextEditingController();
    showModalBottomSheet(
        enableDrag: true,
        context: context,
        isDismissible: false,
        barrierColor: Colors.black.withOpacity(0.8),
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            ),
            child: Column(
              children: [
                boldtext(Ccolor.textblack, 14, "Child Data"),
                vertical(20),
                textarea(name, "NAME", 0.9),
                vertical(15),
                textarea(gender, "GENDER", 0.9),
                vertical(15),
                textarea(age, "AGE", 0.9),
                vertical(15),
                textarea(school, "SCHOOL", 0.9),
                vertical(15),
                buttonmain(() async {
                  try {
                    await FirebaseFirestore.instance
                        .collection(
                            "${CollectionNames.DATABASE}/$DATABASEUID/${CollectionNames.CHILDREEN}")
                        .add({
                      "name": name.text,
                      "age": age.text,
                      "gender": gender.text,
                      "school": school.text
                    });
                    Navigator.pop(context);
                  } catch (e) {
                    print(e.toString());
                  }
                }, "Save", 0.4, context)
              ],
            ),
          );
        });
  }
}
