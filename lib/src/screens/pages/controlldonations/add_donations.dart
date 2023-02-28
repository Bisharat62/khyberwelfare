import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khyberwelfareforum/src/components/appbar.dart';
import 'package:khyberwelfareforum/src/components/globals.dart';

import '../../../components/loader.dart';
import '../../../components/network/chechinternet.dart';
import '../../../components/network/firebase/collection_names.dart';
import '../../../helpers/button.dart';
import '../../../helpers/color.dart';
import '../../../helpers/const_text.dart';
import '../../../helpers/spacer.dart';
import '../../../helpers/text_decor.dart';
import '../../authentication/signup.dart';

class AddDonationsScreen extends StatefulWidget {
  const AddDonationsScreen({super.key});

  @override
  State<AddDonationsScreen> createState() => _AddDonationsScreenState();
}

class _AddDonationsScreenState extends State<AddDonationsScreen> {
  List<String> dateParts = DateTime.now().toString().split("-");
  List<String> images = [];
  String localpath = "";
  int donation = 0;
  final ImagePicker picker = ImagePicker();
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  TextEditingController amount = TextEditingController();
  TextEditingController source = TextEditingController();
  TextEditingController remarks = TextEditingController();
  TextEditingController date = TextEditingController();
  @override
  Widget build(BuildContext context) {
    date.text = DateTime.now().toString().split(" ").first;
    return Scaffold(
      appBar: Appbar(
        globalKey: _key,
        title: "Add Donations",
        back: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              textarea(amount, "Donation Amount"),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    checkboxcard(() {
                      setState(() {
                        source.text = "Bank";
                      });
                    }, source.text == "Bank", "Bank"),
                    checkboxcard(() {
                      setState(() {
                        source.text = "JazzCash";
                      });
                    }, source.text == "JazzCash", "JazzCash"),
                  ],
                ),
              ),
              textarea(remarks, "Remarks"),
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
                if (amount.text.isEmpty ||
                    source.text.isEmpty ||
                    remarks.text.isEmpty) {
                  try {
                    donation = int.parse(amount.text);
                    print(donation);
                    print("not error");
                  } catch (e) {
                    print(donation);
                    print("error");
                  }
                  showInSnackBar("Please Fill all Fields", color: Colors.red);
                } else {
                  loginloader(context);
                  try {
                    donation = int.parse(amount.text);
                  } catch (e) {
                    print(donation);
                    print("error");
                  }
                  try {
                    await FirebaseFirestore.instance
                        .collection(CollectionNames.DONATIONS)
                        .add({
                      "amount": donation,
                      "source": source.text,
                      "remarks": remarks.text,
                      "date": date.text,
                      "images": images,
                      "uploadby": USEREMAIL,
                      "month": "${dateParts[0]}-${dateParts[1]}"
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
