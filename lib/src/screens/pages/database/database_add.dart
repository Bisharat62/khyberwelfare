// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khyberwelfareforum/src/components/globals.dart';
import 'package:khyberwelfareforum/src/components/network/chechinternet.dart';
import 'package:khyberwelfareforum/src/components/network/firebase/api.dart';
import 'package:khyberwelfareforum/src/components/network/firebase/collection_names.dart';
import 'package:khyberwelfareforum/src/helpers/button.dart';
import 'package:khyberwelfareforum/src/helpers/color.dart';
import 'package:khyberwelfareforum/src/helpers/const_text.dart';
import 'package:khyberwelfareforum/src/helpers/spacer.dart';
import 'package:khyberwelfareforum/src/screens/pages/database/utils_database/add_database_utils.dart';
import 'package:khyberwelfareforum/src/screens/pages/database/view_childrens.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../components/loader.dart';
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
          .add({"time": DateTime.now().toString(), "name": "empty"})
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
  TextEditingController gender = TextEditingController();
  TextEditingController maritalstatus = TextEditingController();
  bool yes = false;
  bool no = false;
  TextEditingController house = TextEditingController();
  bool own = false;
  bool rent = false;
  TextEditingController address = TextEditingController();
  TextEditingController details = TextEditingController();

  bool first = false;
  bool second = false;
  bool alive = true;
  String imgName = "";
  String localpath = "";

  String cimgurl = "";
  String deathcertificate = "";
  int imgindex = 1;
  final ImagePicker picker = ImagePicker();
  String imgUrl = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    create();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Ccolor.btnbg,
        title: boldtext(Ccolor.textblack, 14, "Add Database"),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              deletedatabase();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AddDatabaseHeader(
                imgurl: imgUrl,
                ontap: () {
                  setState(() {
                    imgindex = 1;
                  });
                  uploadingImage();
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textarea(name, "NAME*", 0.4),
                  textarea(fname, "F/NAME*", 0.4),
                ],
              ),
              vertical(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textarea(phone, "CONTACT*", 0.3),
                  textarea(age, "AGE*", 0.25),
                  textarea(education, "EDUCATION*", 0.3),
                ],
              ),
              vertical(15),
              textarea(gender, "GENDER*", 0.9),
              textarea(course, "ANY TECHNICAL/COMPUTER COURSE", 0.9),
              vertical(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textarea(experiance, "EXPERIANCE*", 0.4),
                  // textarea(cnic, "CNIC*", 0.4),
                ],
              ),
              SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    boldtext(Ccolor.texthint, 14, 'CNIC'),
                    SizedBox(
                      height: 40,
                      child: TextFormField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(15),
                        ],
                        style: const TextStyle(color: Colors.black),
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
                            prefixIcon: Icon(
                              Icons.contact_mail_outlined,
                            ),
                            hintText: "Enter Your Cnic",
                            hintStyle:
                                TextStyle(color: Theme.of(context).hintColor),
                            // border: InputBorder.none,
                            contentPadding: const EdgeInsets.only(left: 10),
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
              boldtext(Ccolor.texthint, 14, "Salary*"),
              vertical(10),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
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
                    }, salary.text == "Jobless", "JOBLESS"),
                  ],
                ),
              ),
              vertical(15),
              Row(
                children: [
                  boldtext(Ccolor.texthint, 14, "MARITAL STATUS*"),
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
                  boldtext(Ccolor.texthint, 14, "HOUSE*"),
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
              child == true
                  ? ViewChildrensWidget(
                      docid: DATABASEUID.toString(),
                    )
                  : const SizedBox.shrink(),
              Center(
                child: buttonmain(() {
                  addchild(context);
                  setState(() {
                    imgindex = 2;
                  });
                }, "ADD CHILD", 0.5, context, height: 35, fsize: 12),
              ),
              vertical(15),
              textarea(address, "ADDRESS*", 0.9),
              vertical(15),
              Row(
                children: [
                  boldtext(Ccolor.textblack, 14, "Alive"),
                  horizental(25),
                  checkboxcard(() {
                    setState(() {
                      alive = true;
                    });
                  }, alive, "YES"),
                  checkboxcard(() {
                    setState(() {
                      alive = false;
                    });
                  }, alive == false, "NO")
                ],
              ),
              vertical(15),
              alive == false
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buttonmain(() {
                          uploadingImage();
                          setState(() {
                            imgindex = 3;
                          });
                        }, "Add Death Certificate", 0.3, context,
                            fsize: 12, height: 40),
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  width: 1, color: Ccolor.textblack)),
                          child: deathcertificate == ""
                              ? const SizedBox.shrink()
                              : Image.network(
                                  deathcertificate,
                                  width: 100,
                                  height: 100,
                                ),
                        )
                      ],
                    )
                  : const SizedBox(),
              vertical(15),
              boldtext(Ccolor.texthint, 12,
                  "ANY CHRONIC AILMENT TO ANY FAMILY MEMBER"),
              textarea(details, "DETAILS", 0.9),
              vertical(25),
              Center(
                child: buttonmain(() async {
                  if (name.text.isEmpty ||
                      fname.text.isEmpty ||
                      phone.text.isEmpty ||
                      age.text.isEmpty ||
                      education.text.isEmpty ||
                      // course.text.isEmpty ||
                      experiance.text.isEmpty ||
                      cnic.text.isEmpty ||
                      // job.text.isEmpty ||
                      salary.text.isEmpty ||
                      maritalstatus.text.isEmpty ||
                      house.text.isEmpty ||
                      address.text.isEmpty) {
                    showInSnackBar("Please Fill all fields", color: Colors.red);
                  } else {
                    var exist = await checking(
                        context, cnic.text, CollectionNames.DATABASE);
                    print('exist $exist');
                    if (exist == false) {
                      incresesaved();
                      FirebaseApi.uploadDatabase(context, {
                        "formno": "${USEREMAIL!.split("@").first}$ADDEDFORMS",
                        // 'serialno': documents + 1,
                        "name": name.text,
                        "fname": fname.text,
                        "phone": phone.text,
                        "age": age.text,
                        "education": education.text,
                        "course": course.text,
                        "experiance": experiance.text,
                        "cnic": cnic.text,
                        "gender": gender.text,
                        "job": onjob == true
                            ? "${job.text} onjob"
                            : "Searching Job",
                        "salary": salary.text,
                        "maritalstatus": maritalstatus.text,
                        "house": house.text,
                        "address": address.text,
                        "details": details.text,
                        "imgurl": imgUrl,
                        "alive": alive ? "YES" : "NO",
                        "deathimgurl": alive == false ? deathcertificate : "",
                        "createdby": USEREMAIL,
                      });
                    }
                  }
                }, "Save", 0.5, context),
              ),
              vertical(25),
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
                    contentPadding: const EdgeInsets.only(left: 10),
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
    final TextEditingController cname = TextEditingController();
    final TextEditingController cgender = TextEditingController();
    final TextEditingController cage = TextEditingController();
    final TextEditingController cbirthcertificate = TextEditingController();
    final TextEditingController ccnic = TextEditingController();
    final TextEditingController ceducation = TextEditingController();
    final TextEditingController cskill = TextEditingController();
    final TextEditingController ccourse = TextEditingController();
    final TextEditingController cjob = TextEditingController();
    final TextEditingController cdrug = TextEditingController();
    final TextEditingController csports = TextEditingController();
    final TextEditingController cdisablityoption = TextEditingController();
    final TextEditingController cdisability = TextEditingController();
    bool hafiz = false;
    bool alim = false;
    showModalBottomSheet(
        enableDrag: true,
        context: context,
        isDismissible: false,
        isScrollControlled: true,
        barrierColor: Colors.black.withOpacity(0.8),
        backgroundColor: Colors.transparent,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                height: MediaQuery.of(context).size.height * 0.9,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      boldtext(Ccolor.textblack, 14, "Child Data"),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: imgicon(context, cimgurl, () {
                            // setState(() {
                            //   imgindex = 2;
                            // });
                            uploadingImage();
                          })),
                      vertical(20),
                      textarea(cname, "NAME*", 0.9),
                      textarea(cgender, "GENDER*", 0.9),
                      textarea(cage, "AGE*", 0.9),
                      textarea(cbirthcertificate, "BIRTH CERTIFICATE NO", 0.95),
                      textarea(ccnic, "CNIC (If Made)", 0.9),
                      textarea(csports, "SPORTS", 0.9),
                      boldtext(Ccolor.textblack, 12, "EDUCATION"),
                      SizedBox(
                        height: 70,
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: [
                            checkboxcard(() {
                              setState(
                                () {
                                  ceducation.text = "Primary";
                                },
                              );
                            }, ceducation.text == "Primary", "Primary"),
                            checkboxcard(() {
                              setState(
                                () {
                                  ceducation.text = "Middle";
                                },
                              );
                            }, ceducation.text == "Middle", "Middle"),
                            checkboxcard(() {
                              setState(
                                () {
                                  ceducation.text = "Matric";
                                },
                              );
                            }, ceducation.text == "Matric", "Matric"),
                            checkboxcard(() {
                              setState(
                                () {
                                  ceducation.text = "Intermediate";
                                },
                              );
                            }, ceducation.text == "Intermediate",
                                "Intermediate"),
                            checkboxcard(() {
                              setState(
                                () {
                                  ceducation.text = "Graduation";
                                },
                              );
                            }, ceducation.text == "Graduation", "Graduation"),
                            checkboxcard(() {
                              setState(
                                () {
                                  hafiz = !hafiz;
                                },
                              );
                            }, hafiz, "Hafiz Quran"),
                            checkboxcard(() {
                              setState(
                                () {
                                  alim = !alim;
                                },
                              );
                            }, alim, "Alim"),
                          ],
                        ),
                      ),
                      textarea(cskill, "TECHNICAL SKILLS", 0.9),
                      textarea(ccourse, "IT Course", 0.9),
                      Row(
                        children: [
                          boldtext(Ccolor.textblack, 12, "Job"),
                          horizental(30),
                          checkboxcard(() {
                            setState(
                              () {
                                cjob.text = "Yes";
                              },
                            );
                          }, cjob.text == "Yes", "Yes"),
                          checkboxcard(() {
                            setState(
                              () {
                                cjob.text = "No";
                              },
                            );
                          }, cjob.text == "No", "No")
                        ],
                      ),
                      vertical(15),
                      Row(
                        children: [
                          boldtext(Ccolor.textblack, 12, "DRUG ADDICTED"),
                          horizental(30),
                          checkboxcard(() {
                            setState(
                              () {
                                cdrug.text = "Yes";
                              },
                            );
                          }, cdrug.text == "Yes", "Yes"),
                          checkboxcard(() {
                            setState(
                              () {
                                cdrug.text = "No";
                              },
                            );
                          }, cdrug.text == "No", "No")
                        ],
                      ),
                      textarea(cdisability, "Any Disability", 0.9),
                      vertical(30),
                      Center(
                        child: buttonmain(() async {
                          String haf = hafiz ? "Hafiz" : "";
                          String ali = alim ? "Alim" : "";
                          print(cimgurl);
                          if (cname.text.isEmpty ||
                              cgender.text.isEmpty ||
                              cage.text.isEmpty) {
                            showInSnackBar("Please Fill Important Fields",
                                color: Colors.red);
                          } else {
                            loginloader(context);
                            try {
                              await FirebaseFirestore.instance
                                  .collection(
                                      "${CollectionNames.DATABASE}/$DATABASEUID/${CollectionNames.CHILDREEN}")
                                  .add({
                                "cimgurl": cimgurl,
                                "name": cname.text,
                                "age": cage.text,
                                "gender": cgender.text,
                                "sports": csports.text.isEmpty
                                    ? "No Any"
                                    : csports.text,
                                "birthcertificate":
                                    cbirthcertificate.text.isEmpty
                                        ? "Not Available"
                                        : cbirthcertificate.text,
                                "cnic": ccnic.text,
                                "sports": csports.text,
                                "education": education.text.isEmpty &&
                                        alim == false &&
                                        hafiz == false
                                    ? "Not Available"
                                    : "${education.text} $haf  $ali",
                                "skills": cskill.text.isEmpty
                                    ? "Not Available"
                                    : cskill.text,
                                "itcource": ccourse.text.isEmpty
                                    ? "Not Available"
                                    : ccourse.text,
                                "job": cjob.text.isEmpty
                                    ? "Not Available"
                                    : cjob.text,
                                "drug": cdrug.text.isEmpty
                                    ? "Not Available"
                                    : cdrug.text,
                                "disability": cdisability.text.isEmpty
                                    ? "Not Available"
                                    : cdisability.text,
                                "time": DateTime.now().toString()
                              });
                              Navigator.pop(context);
                              Navigator.pop(context);
                            } catch (e) {
                              Navigator.pop(context);
                              print(e.toString());
                            }
                          }
                        }, "Save", 0.4, context),
                      ),
                      vertical(180),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  uploadingImage() async {
    try {
      final photo = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        localpath = (photo!.path);
      });
      uploadingtostorage();
    } catch (e) {
      print(e);
      print('No path selected.');
    }
  }

  uploadingtostorage() async {
    loginloader(context);
    final storageRef = FirebaseStorage.instance.ref();
    String url;
    File image;
    String imgname = localpath.split("/").last;
    if (localpath != null) {
      image = File(localpath);
      final mountainImagesRef = storageRef.child("database/$imgname");
      try {
        await mountainImagesRef.putFile(image);
        url = await (mountainImagesRef).getDownloadURL();
        setState(() {
          if (imgindex == 1) {
            imgUrl = url;
          } else if (imgindex == 3) {
            deathcertificate = url;
          } else {
            cimgurl = url;
            print(cimgurl);
          }
        });
        // savedata();
        print(imgUrl);
      } catch (e) {
        print(e.toString());
      }
    } else {
      print('No image selected.');
      return;
    }
    loginloader(context, back: true);
  }
}

deletedatabase() async {
  try {
    await FirebaseFirestore.instance
        .collection(CollectionNames.DATABASE)
        .doc(DATABASEUID)
        .delete()
        .then((value) => print("deleted"));
  } catch (e) {
    print(e.toString());
  }
}

incresesaved() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  int? data = _prefs.getInt("addedforms");
  data = (data! + 1);
  _prefs.setInt("addedforms", data);
  ADDEDFORMS = data;
  await FirebaseFirestore.instance
      .collection(CollectionNames.USER)
      .doc(USERUID)
      .update({"addedforms": data});
}
