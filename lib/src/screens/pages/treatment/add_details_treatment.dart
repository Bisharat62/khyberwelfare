import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khyberwelfareforum/src/components/network/chechinternet.dart';
import 'package:khyberwelfareforum/src/components/network/firebase/collection_names.dart';
import 'package:khyberwelfareforum/src/helpers/button.dart';
import 'package:khyberwelfareforum/src/helpers/spacer.dart';

import '../../../components/appbar.dart';
import '../../../components/globals.dart';
import '../../../components/loader.dart';
import '../../../helpers/color.dart';
import '../../../helpers/const_text.dart';
import '../../../helpers/text_decor.dart';

class AddTreatment extends StatefulWidget {
  const AddTreatment({super.key});

  @override
  State<AddTreatment> createState() => _AddTreatmentState();
}

class _AddTreatmentState extends State<AddTreatment> {
  List<String> images = [];
  String localpath = "";

  final ImagePicker picker = ImagePicker();
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  TextEditingController namehospital = TextEditingController();
  TextEditingController fpname = TextEditingController();
  TextEditingController fpPhone = TextEditingController();
  TextEditingController patientName = TextEditingController();
  TextEditingController patientCnic = TextEditingController();
  TextEditingController patientPhone = TextEditingController();
  TextEditingController treatment = TextEditingController();
  TextEditingController date = TextEditingController();

  @override
  Widget build(BuildContext context) {
    date.text = DateTime.now().toString().split(" ").first;
    return Scaffold(
      appBar: Appbar(globalKey: _key, title: "Add Tratment Details"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              vertical(30),
              textarea(namehospital, "Hospital Name"),
              textarea(fpname, "Focal Person Name"),
              textarea(fpPhone, "Focal Person  Contact NO#"),
              textarea(patientName, "Patient Name"),
              textarea(patientCnic, "Patient CNIC"),
              textarea(patientPhone, "Patient Phone NO#"),
              textarea(treatment, "Treatment Details"),
              textarea(date, "Date"),
              images.isEmpty
                  ? const SizedBox.shrink()
                  : SizedBox(
                      height: 100,
                      child: ListView.builder(
                        itemCount: images.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Image.network(images[index]);
                        },
                      ),
                    ),
              vertical(30),
              buttonmain(() {
                uploadingImage();
              }, "upload photos", 0.5, context, fsize: 13, height: 35),
              vertical(30),
              buttonmain(() async {
                if (namehospital.text.isEmpty ||
                    fpname.text.isEmpty ||
                    fpPhone.text.isEmpty ||
                    patientName.text.isEmpty ||
                    patientCnic.text.isEmpty ||
                    patientPhone.text.isEmpty ||
                    treatment.text.isEmpty) {
                  showInSnackBar("Please Fill all Fields", color: Colors.red);
                } else {
                  loginloader(context);
                  try {
                    await FirebaseFirestore.instance
                        .collection(CollectionNames.TREATMENT)
                        .add({
                      "namehospital": namehospital.text,
                      "fpname": fpname.text,
                      "fpPhone": fpPhone.text,
                      "patientName": patientName.text,
                      "patientCnic": patientCnic.text,
                      "patientPhone": patientPhone.text,
                      "treatment": treatment.text,
                      "date": date.text,
                      "images": images,
                      "uploadby": USEREMAIL,
                    });
                    showInSnackBar(
                      "Data Saved",
                    );
                    loginloader(context, back: true);
                    Navigator.pop(context);
                  } catch (e) {
                    print(e.toString());
                    loginloader(context, back: true);
                    showInSnackBar("Try Again", color: Colors.red);
                  }
                }
              }, "Save", 0.5, context, fsize: 13, height: 35),
              vertical(40)
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
                readOnly: hint == "Date" ? true : false,
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
          images.add(url);
        });
        // savedata();
        print(url);
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
