// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khyberwelfareforum/src/components/appbar.dart';
import 'package:khyberwelfareforum/src/components/globals.dart';
import 'package:khyberwelfareforum/src/components/network/chechinternet.dart';
import 'package:khyberwelfareforum/src/helpers/button.dart';

import '../../../../components/loader.dart';
import '../../../../components/network/firebase/api.dart';
import '../../../../helpers/color.dart';
import '../../../../helpers/const_text.dart';
import '../../../../helpers/networkImage.dart';
import '../../../../helpers/spacer.dart';
import '../../../../helpers/text_decor.dart';
import '../../../authentication/signup.dart';
import '../utils_database/add_database_utils.dart';

class AddFoodSecurity extends StatefulWidget {
  String title;
  String collectionName;
  AddFoodSecurity(
      {super.key, required this.title, required this.collectionName});

  @override
  State<AddFoodSecurity> createState() => _AddFoodSecurityState();
}

class _AddFoodSecurityState extends State<AddFoodSecurity> {
  findLength() async {
    try {
      FirebaseFirestore.instance
          .collection(widget.collectionName)
          .get()
          .then((value) {
        print(value.docs.length);
        setState(() {
          length = (value.docs.length + 1).toString();
        });
      });
    } catch (e) {}
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController elder = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController gender = TextEditingController();
  final TextEditingController childrens = TextEditingController();
  final TextEditingController cnic = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController district = TextEditingController();
  final TextEditingController contact = TextEditingController();
  final TextEditingController salaray = TextEditingController();
  final TextEditingController accountno = TextEditingController();
  final TextEditingController accounttype = TextEditingController();
  final TextEditingController accountdetails = TextEditingController();
  final TextEditingController residence = TextEditingController();
  final TextEditingController rentAmount = TextEditingController();
  final TextEditingController discription = TextEditingController();
  //----------------------------------------------------------------------------------------------------------------------------------------------
  final TextEditingController verifiedBy = TextEditingController();
  final TextEditingController userName = TextEditingController();
  final TextEditingController userCnic = TextEditingController();
  final TextEditingController designation = TextEditingController();
  final TextEditingController userContact = TextEditingController();
  String ownImg = '';
  String birthCertificateImg = '';
  String deathCertificateImg = '';
  String disablityCertificateImg = '';
  String cnicOf = '';
  String deathCertificateOf = '';
  bool first = false;
  bool second = false;
  int index = 0;
  String imgName = "";
  String localpath = "";
  String length = '***';
  final ImagePicker picker = ImagePicker();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findLength();
  }

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.bottomRight,
                  child: imgicon(context, ownImg, () {
                    setState(() {
                      index = 0;
                    });
                    uploadingImage();
                  })),

              boldtext(Ccolor.textblack, 12, "KWF ID NO   : ${length}"),
              vertical(10),
              vertical(15),
              textarea(name, 'Name', 0.9),
              textarea(elder, 'S/O , D/O , W/O', 0.9),
              textarea(age, 'AGE', 0.9),
              textarea(gender, 'Gender', 0.9),
              textarea(childrens, 'NAME OF CHILDREEN / SIBLINGS WITH AGE', 0.9),
              vertical(15),
              SizedBox(
                height: 120,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    boldtext(Ccolor.texthint, 14,
                        'CNIC NO OF FATHER / MOTHER / HUSBAND'),
                    vertical(15),
                    Row(
                      children: [
                        checkboxcard(() {
                          setState(() {
                            cnicOf = 'FATHER';
                          });
                        }, cnicOf == 'FATHER', "FATHER", fsize: 10),
                        checkboxcard(() {
                          setState(() {
                            cnicOf = 'MOTHER';
                          });
                        }, cnicOf == 'MOTHER', "MOTHER", fsize: 10),
                        checkboxcard(() {
                          setState(() {
                            cnicOf = 'HUSBAND';
                          });
                        }, cnicOf == 'HUSBAND', "HUSBAND", fsize: 10),
                      ],
                    ),
                    vertical(15),
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
              vertical(20),
              textarea(address, 'ADDRESS', 0.9),
              textarea(district, 'DISTRICT / TOWN', 0.9),
              textarea(contact, 'CONTACT NO', 0.9),
              textarea(salaray, 'SALARY / INCOME', 0.9),
              vertical(15),
              boldtext(Ccolor.texthint, 14, 'ACCOUNT TYPE'),
              vertical(10),
              Row(
                children: [
                  checkboxcard(() {
                    setState(() {
                      accounttype.text = 'EASYPAISA';
                    });
                  }, accounttype.text == 'EASYPAISA', "EASYPAISA", fsize: 10),
                  checkboxcard(() {
                    setState(() {
                      accounttype.text = 'JAZZ CASH';
                    });
                  }, accounttype.text == 'JAZZ CASH', "JAZZ CASH", fsize: 10),
                  checkboxcard(() {
                    setState(() {
                      accounttype.text = 'BANK';
                    });
                  }, accounttype.text == 'BANK', "BANK", fsize: 10),
                ],
              ),
              textarea(accountdetails, 'ACCOUNT DETAILS', 0.9),
              textarea(accountno, 'ACCOUNT NO', 0.9),
              vertical(15),
              boldtext(Ccolor.texthint, 14, 'RESIDENCE'),
              vertical(10),
              Row(
                children: [
                  checkboxcard(() {
                    setState(() {
                      residence.text = 'OWN';
                    });
                  }, residence.text == 'OWN', "OWN", fsize: 10),
                  checkboxcard(() {
                    setState(() {
                      residence.text = 'RENT';
                    });
                  }, residence.text == 'RENT', "RENT", fsize: 10),
                ],
              ),
              residence.text == 'RENT'
                  ? textarea(rentAmount, 'RENT AMOUNT', 0.9)
                  : const SizedBox.shrink(),
              textarea(
                  discription, 'DESCRIPTION / COMMENTS BY KWF VOLUNTEER', 0.9),
              vertical(20),
              ViewImageNetwork(
                imgUrl: birthCertificateImg,
              ),
              buttonmain(() {
                setState(() {
                  index = 1;
                });
                uploadingImage();
              }, 'UPLOAD BIRTH CERTIFICATE', 0.7, context,
                  fsize: 13,
                  height: 35,
                  color: Colors.grey,
                  showborder: true,
                  noborder: true),
              vertical(25),

              ViewImageNetwork(
                imgUrl: deathCertificateImg,
              ),
              boldtext(Ccolor.texthint, 14,
                  'DEATH CERTIFICATE OF FATHER / MOTHER / HUSBAND'),
              vertical(15),
              Row(
                children: [
                  checkboxcard(() {
                    setState(() {
                      deathCertificateOf = 'FATHER';
                    });
                  }, deathCertificateOf == 'FATHER', "FATHER", fsize: 10),
                  checkboxcard(() {
                    setState(() {
                      deathCertificateOf = 'MOTHER';
                    });
                  }, deathCertificateOf == 'MOTHER', "MOTHER", fsize: 10),
                  checkboxcard(() {
                    setState(() {
                      deathCertificateOf = 'HUSBAND';
                    });
                  }, deathCertificateOf == 'HUSBAND', "HUSBAND", fsize: 10),
                ],
              ),
              vertical(20),
              buttonmain(() {
                setState(() {
                  index = 2;
                });
                uploadingImage();
              }, 'UPLOAD DEATH CERTIFICATE', 0.7, context,
                  fsize: 13,
                  height: 35,
                  color: Colors.grey,
                  showborder: true,
                  noborder: true),
              vertical(20),
              ViewImageNetwork(
                imgUrl: disablityCertificateImg,
              ),
              widget.title.contains('DISABLED')
                  ? buttonmain(() {
                      setState(() {
                        index = 3;
                      });
                      uploadingImage();
                    }, 'UPLOAD DISABILITY CERTIFICATE', 0.7, context,
                      fsize: 13,
                      height: 35,
                      color: Colors.grey,
                      showborder: true,
                      noborder: true)
                  : const SizedBox.shrink(),
              vertical(30),
              const Divider(
                thickness: 4,
                color: Colors.black,
              ),
              //----------------------------------------------------------------------------------------------------------------------------------------------
              vertical(30),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    textarea(verifiedBy, 'VERIFIED BY', 0.5),
                    textarea(userName, 'NAME', 0.5),
                    textarea(userCnic, 'CNIC', 0.5),
                    textarea(designation, 'DESIGNATION', 0.5),
                    textarea(userContact, 'CONTACT NO', 0.5),
                  ],
                ),
              ),
              vertical(25),
              buttonmain(() async {
                if (name.text.isEmpty ||
                    elder.text.isEmpty ||
                    age.text.isEmpty ||
                    gender.text.isEmpty ||
                    childrens.text.isEmpty ||
                    cnic.text.isEmpty ||
                    address.text.isEmpty ||
                    district.text.isEmpty ||
                    contact.text.isEmpty ||
                    salaray.text.isEmpty ||
                    accountno.text.isEmpty ||
                    accounttype.text.isEmpty ||
                    accountdetails.text.isEmpty ||
                    residence.text.isEmpty ||
                    discription.text.isEmpty ||
                    verifiedBy.text.isEmpty ||
                    userName.text.isEmpty ||
                    userCnic.text.isEmpty ||
                    designation.text.isEmpty ||
                    userContact.text.isEmpty) {
                  showInSnackBar('Please Fill all Fields', color: Colors.red);
                } else {
                  var exist =
                      await checking(context, cnic.text, widget.collectionName);
                  print('exist $exist');
                  if (exist == false) {
                    FirebaseApi.uploadFoodSecurity(
                        context,
                        {
                          'time': DateTime.now().toString().split(' ').first,
                          'uploadedBy': USEREMAIL,
                          "name": name.text,
                          "elder": elder.text,
                          "age": age.text,
                          "gender": gender.text,
                          "childrens": childrens.text,
                          "cnic": cnic.text,
                          "address": address.text,
                          "district": district.text,
                          "contact": contact.text,
                          "salaray": salaray.text,
                          "accountno": accountno.text,
                          "accounttype": accounttype.text,
                          "accountdetails": accountdetails.text,
                          "residence": residence.text + rentAmount.text,
                          "discription": discription.text,
                          "verifiedBy": verifiedBy.text,
                          "userName": userName.text,
                          "userCnic": userCnic.text,
                          "designation": designation.text,
                          "userContact": userContact.text,
                          "ownImg": ownImg,
                          "birthCertificateImg": birthCertificateImg,
                          "deathCertificateImg": deathCertificateImg,
                          "disablityCertificateImg": disablityCertificateImg,
                          "cnicOf": cnicOf,
                          "deathCertificateOf": deathCertificateOf,
                        },
                        widget.collectionName);
                  }
                }
              }, 'SAVE', 0.9, context),
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
      final mountainImagesRef = storageRef.child("foodSecurity/$imgname");
      try {
        await mountainImagesRef.putFile(image);
        url = await (mountainImagesRef).getDownloadURL();
        setState(() {
          if (index == 0) {
            ownImg = url;
          } else if (index == 1) {
            birthCertificateImg = url;
          } else if (index == 2) {
            deathCertificateImg = url;
          } else if (index == 3) {
            disablityCertificateImg = url;
          }
        });
        // savedata();
        // print(imgUrl);
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
