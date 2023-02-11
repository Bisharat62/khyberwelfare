import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khyberwelfareforum/src/components/appbar.dart';
import 'package:khyberwelfareforum/src/components/network/signup_network.dart';
import 'package:khyberwelfareforum/src/screens/authentication/signin.dart';

import '../../components/network/chechinternet.dart';
import '../../helpers/button.dart';
import '../../helpers/color.dart';
import '../../helpers/const_text.dart';
import '../../helpers/spacer.dart';
import '../../helpers/text_decor.dart';

class SignUpScreen extends StatefulWidget {
  bool? create;
  String? title;
  SignUpScreen({super.key, this.create, this.title});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final TextEditingController fname = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController cnic = TextEditingController();
  final TextEditingController profession = TextEditingController();
  final TextEditingController salary = TextEditingController();
  final TextEditingController dist = TextEditingController();
  final TextEditingController tehsil = TextEditingController();
  final TextEditingController tribe = TextEditingController();
  final TextEditingController designation = TextEditingController();
  final TextEditingController gender = TextEditingController();
  final TextEditingController uc = TextEditingController();
  final TextEditingController disability = TextEditingController();
  final TextEditingController address = TextEditingController();
  bool firstm = false;
  bool first = false;
  bool second = false;
  bool less30 = false;
  bool less60 = false;
  bool less90 = false;
  bool jobless = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.create == true
          ? Appbar(globalKey: _key, title: widget.title.toString())
          : null,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              vertical(50),
              boldtext(Ccolor.textblack, 25, 'Sign Up'),
              vertical(10),
              mediumtext(Ccolor.texthint, 18,
                  'Create an account to access full version with all features'),
              vertical(50),
              textarea(name, 'Name*'),
              textarea(fname, "Father's Name*"),
              textarea(email, 'Email*'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: SizedBox(
                  height: 60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      boldtext(Ccolor.texthint, 14, 'Phone*'),
                      SizedBox(
                        height: 40,
                        child: TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(12),
                          ],
                          keyboardType: TextInputType.number,
                          style: textfieldtextstyle,
                          controller: phone,
                          onChanged: (value) {
                            print('lengthis ${value.length}');
                            if (value.length == 3) {
                              setState(() {
                                firstm = true;
                              });
                            }
                            if (value.length == 4 && first == true) {
                              phone.text = value + ' ';
                              phone.selection = TextSelection.collapsed(
                                  offset: phone.text.length);
                              setState(() {
                                firstm = false;
                              });
                            }
                          },
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 25),
                              prefix: boldtext(Ccolor.texthint, 14, ''),
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Ccolor.texthint)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Ccolor.texthint)),
                              fillColor: Ccolor.textwhite),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              textarea(pass, 'Password*'),
              textarea(age, 'Age*'),
              textarea(gender, 'Gender*'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: SizedBox(
                  height: 60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      boldtext(Ccolor.texthint, 14, "Cnic*"),
                      SizedBox(
                        height: 40,
                        child: TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(15),
                          ],
                          style: TextStyle(color: Colors.black),
                          controller: cnic,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            // print('lengthis ${value.length}');
                            if (value.length == 4) {
                              setState(() {
                                first = true;
                              });
                            }
                            if (value.length == 5 && first == true) {
                              cnic.text = value + '-';
                              cnic.selection = TextSelection.collapsed(
                                  offset: cnic.text.length);
                              setState(() {
                                first = false;
                              });
                            }
                            if (value.length == 12) {
                              setState(() {
                                second = true;
                              });
                            }
                            if (value.length == 13 && second == true) {
                              setState(() {
                                cnic.text = value + '-';
                                cnic.selection = TextSelection.collapsed(
                                    offset: cnic.text.length);
                                second = false;
                              });
                            }
                          },
                          //
                          decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.contact_mail_outlined,
                              ),
                              hintStyle:
                                  TextStyle(color: Theme.of(context).hintColor),
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Ccolor.texthint)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Ccolor.texthint)),
                              fillColor: Ccolor.textwhite),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              textarea(address, 'Address*'),
              textarea(profession, 'Profession*'),
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
                  }, jobless, "Jobless"),
                ],
              ),
              vertical(10),
              widget.title == null
                  ? Column(
                      children: [
                        textarea(tribe, 'Tribe*'),
                        textarea(disability, 'Disability*'),
                      ],
                    )
                  : widget.title!.contains("Member")
                      ? Column(
                          children: [
                            textarea(tribe, 'Tribe*'),
                            textarea(disability, 'Disability*'),
                          ],
                        )
                      : textarea(designation, 'Designation*'),
              textarea(dist, 'Dist*'),
              textarea(tehsil, 'Tehsil*'),
              textarea(uc, 'UC*'),
              vertical(20),
              buttonmain(() {
                if (name.text.isEmpty ||
                    email.text.isEmpty ||
                    phone.text.isEmpty ||
                    pass.text.isEmpty ||
                    fname.text.isEmpty ||
                    age.text.isEmpty ||
                    cnic.text.isEmpty ||
                    profession.text.isEmpty ||
                    salary.text.isEmpty ||
                    dist.text.isEmpty ||
                    tehsil.text.isEmpty ||
                    gender.text.isEmpty ||
                    uc.text.isEmpty) {
                  showInSnackBar('Please Fill All fields', color: Colors.red);
                } else {
                  signup(context, {
                    "name": name.text,
                    "email": email.text.toLowerCase().trim(),
                    "phone": phone.text,
                    "pass": pass.text,
                    "fname": fname.text,
                    "age": age.text,
                    "cnic": cnic.text,
                    "profession": profession.text,
                    "salary": salary.text,
                    "dist": dist.text,
                    "tehsil": tehsil.text,
                    "address": address.text,
                    "addedforms": "0",
                    "tribe": tribe.text == "" ? "Not Available" : tribe.text,
                    "designation":
                        designation.text == "" ? "Member" : designation.text,
                    "gender": gender.text,
                    "uc": uc.text,
                    "time": DateTime.now().toString(),
                    "disability": disability.text == ""
                        ? "No Any Disability"
                        : disability.text,
                    "role": widget.title == null
                        ? "Member"
                        : widget.title!.contains("Member")
                            ? "Member"
                            : widget.title
                  });
                }
              }, widget.create == true ? "Create" : 'Sign Up', 1.0, context),
              vertical(45),
              widget.create == true
                  ? const SizedBox.shrink()
                  : newuser(context, 'Already have an account', 'SingIn',
                      const SignInScreen())
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
                    prefix: (hint == 'Phone*')
                        ? boldtext(Ccolor.texthint, 14, '(+1)')
                        : null,
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

Widget checkboxcard(VoidCallback ontap, bool value, String text,
    {double? fsize}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      children: [
        mediumtext(Ccolor.textblack, fsize ?? 14, text),
        horizental(5),
        InkWell(
          onTap: ontap,
          child: value
              ? Icon(
                  Icons.check_box_sharp,
                  color: Ccolor.btnbg,
                )
              : Icon(
                  Icons.check_box_outline_blank,
                  color: Ccolor.texthint,
                ),
        )
      ],
    ),
  );
}
