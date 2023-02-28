// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:khyberwelfareforum/src/components/globals.dart';
import 'package:khyberwelfareforum/src/components/network/chechinternet.dart';
import 'package:khyberwelfareforum/src/components/network/firebase/api.dart';
import 'package:khyberwelfareforum/src/components/network/lists.dart';
import 'package:khyberwelfareforum/src/helpers/button.dart';
import 'package:khyberwelfareforum/src/helpers/spacer.dart';
import 'package:khyberwelfareforum/src/screens/authentication/signup.dart';
import 'package:khyberwelfareforum/src/screens/pages/homepage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/appbar.dart';
import '../../../helpers/color.dart';
import '../../../helpers/const_text.dart';
import '../../../helpers/text_decor.dart';
import '../accounts/add_details.dart';

class ShowHelpFormScreen extends StatefulWidget {
  String title;
  String committee;
  ShowHelpFormScreen({super.key, required this.title, required this.committee});

  @override
  State<ShowHelpFormScreen> createState() => _ShowHelpFormScreenState();
}

class _ShowHelpFormScreenState extends State<ShowHelpFormScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController fname = TextEditingController();
  final TextEditingController cnic = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController comments = TextEditingController();
  final TextEditingController bottles = TextEditingController();
  final TextEditingController hospital = TextEditingController();
  final TextEditingController collect = TextEditingController();
  final TextEditingController caseno = TextEditingController();
  final TextEditingController year = TextEditingController();
  final TextEditingController policestation = TextEditingController();
  final TextEditingController bloodGroup = TextEditingController();
  bool? blood;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        globalKey: _key,
        title: widget.title,
        back: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              textarea(name, "NAME"),
              textarea(fname, "FATHER'S NAME"),
              textarea(cnic, "CNIC"),
              textarea(phone, "MOBILE NO"),
              textarea(address, "ADDRESS"),
              textarea(comments, "COMMENTS"),
              widget.title == "Medical Help"
                  ? Row(
                      children: [
                        boldtext(Ccolor.textblack, 12, "Do You Need Blood?"),
                        checkboxcard(() {
                          setState(() {
                            blood = true;
                          });
                        }, blood == true, "Yes"),
                        checkboxcard(() {
                          setState(() {
                            blood = false;
                          });
                        }, blood == false, "No")
                      ],
                    )
                  : const SizedBox.shrink(),
              blood == true
                  ? Column(
                      children: [
                        textarea(bloodGroup, "Blood Group"),
                        textarea(bottles, "How Many Bottles"),
                        textarea(hospital, "In Which Hospital"),
                        Row(
                          children: [
                            checkboxcard(() {
                              setState(() {
                                collect.text = "Delivery By KWF";
                              });
                            }, collect.text == "Delivery By KWF",
                                "Delivery By KWF"),
                            checkboxcard(() {
                              setState(() {
                                collect.text = "Self Collection";
                              });
                            }, collect.text == "Self Collection",
                                "Self Collection")
                          ],
                        )
                      ],
                    )
                  : const SizedBox.shrink(),
              widget.title == "Legal Help"
                  ? Column(
                      children: [
                        textarea(caseno, "FIR NO"),
                        textarea(year, "YEAR"),
                        textarea(policestation, "POLICE STATION"),
                      ],
                    )
                  : const SizedBox.shrink(),
              vertical(25),
              buttonmain(() {
                if (name.text.isEmpty ||
                    fname.text.isEmpty ||
                    cnic.text.isEmpty ||
                    address.text.isEmpty) {
                  showInSnackBar("Please Fill All Fields", color: Colors.red);
                } else if (blood == true &&
                    (hospital.text.isEmpty ||
                        bottles.text.isEmpty ||
                        collect.text.isEmpty)) {
                  showInSnackBar("Please Fill Hospital Details",
                      color: Colors.red);
                } else {
                  FirebaseApi.helprequest({
                    "name": name.text,
                    "fname": fname.text,
                    "cnic": cnic.text,
                    "phone": phone.text,
                    "address": address.text,
                    "comments": comments.text,
                    "blood": blood == true ? "YES" : "NO",
                    "bottles": blood == true
                        ? bottles.text.isEmpty
                            ? "Not Available"
                            : bottles.text
                        : "",
                    "bloodgroup": blood == true
                        ? bloodGroup.text.isEmpty
                            ? "Not Available"
                            : bloodGroup.text
                        : "",
                    "hospital": blood == true
                        ? hospital.text.isEmpty
                            ? "Not Available"
                            : hospital.text
                        : "",
                    "deliver": blood == true
                        ? collect.text.isEmpty
                            ? "Not Available"
                            : collect.text
                        : "",
                    "caseno": widget.title == "Legal Help" ? caseno.text : "",
                    "year": widget.title == "Legal Help" ? year.text : "",
                    "policestation":
                        widget.title == "Legal Help" ? policestation.text : "",
                    "time": DateTime.now().toString(),
                    "request": widget.title
                  });
                  viewbottom();
                }
              }, "SEND", 0.5, context)
            ],
          ),
        ),
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

  viewbottom() {
    int index = distnames.indexOf(distName);
    showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: false,
        enableDrag: false,
        backgroundColor: Colors.black.withOpacity(0.3),
        barrierColor: Colors.black.withOpacity(0.9),
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  children: [
                    boldtext(Ccolor.textblack, 14,
                        "Your request is submitted you will be contacted soon if you are in hurry call on bello Number"),
                    vertical(25),
                    const Text(
                      "اگر آپ جلدی میں ہیں تو نیچے دیئے گئے نمبر پر آپ سے جلد ہی رابطہ کیا جائے گا۔",
                      textDirection: TextDirection.rtl,
                    ),
                    const Text(
                      "آپ کی درخواست جمع کر دی گئی ہے آپ سے جلد ہی رابطہ کیا جائے گا۔۔",
                      textDirection: TextDirection.rtl,
                    ),
                    vertical(20),
                    boldtext(Ccolor.textblack, 14, "FOCAL PERSON"),
                    vertical(10),
                    boldtext(Ccolor.texthint, 12, "${personNames[index]}"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        boldtext(Ccolor.textblack, 14, "${personPhone[index]}"),
                        IconButton(
                            onPressed: () {
                              _launchCaller("${personPhone[index]}");
                            },
                            icon: const Icon(
                              Icons.call,
                              size: 30,
                              color: Colors.green,
                            ))
                      ],
                    ),
                    vertical(20),
                    viewCommiteNumbers(context, widget.committee, call: true),
                    vertical(25),
                    buttonmain(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomepageScreen()));
                    }, "Done", 1, context)
                  ],
                ),
              ),
            ),
          );
        });
  }
}

_launchCaller(String num) async {
  final url = "tel:$num";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
