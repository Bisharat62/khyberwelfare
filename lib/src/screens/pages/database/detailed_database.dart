import 'package:flutter/material.dart';
import 'package:khyberwelfareforum/src/components/appbar.dart';
import 'package:khyberwelfareforum/src/helpers/color.dart';
import 'package:khyberwelfareforum/src/helpers/const_text.dart';
import 'package:khyberwelfareforum/src/helpers/spacer.dart';
import 'package:khyberwelfareforum/src/screens/pages/database/utils_database/add_database_utils.dart';
import 'package:khyberwelfareforum/src/screens/pages/database/view_childrens.dart';

class DetailedDatabase extends StatefulWidget {
  dynamic data;
  String docid;
  DetailedDatabase({super.key, required this.data, required this.docid});

  @override
  State<DetailedDatabase> createState() => _DetailedDatabaseState();
}

class _DetailedDatabaseState extends State<DetailedDatabase> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  double fsize = 12;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        globalKey: _key,
        title: "Database",
        back: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AddDatabaseHeader(
                imgurl: widget.data['imgurl'].toString(),
                ontap: () {},
                formno: widget.data['formno'],
                view: true,
              ),
              boldtext(Ccolor.textblack, 12,
                  "NAME :  ${widget.data['name']}__________ F/NAME :  ${widget.data['fname']}"),
              vertical(10),
              boldtext(Ccolor.textblack, 12,
                  "CONTACT :${widget.data['phone']}_____AGE : ${widget.data['age']}____ EDUCATION :${widget.data['education']} "),
              vertical(10),
              boldtext(Ccolor.textblack, 12,
                  "ANY TECHNICAL/COMPUTER COURSE : ${widget.data['course']}"),
              vertical(10),
              boldtext(Ccolor.textblack, 12, "JOB : ${widget.data['job']}"),
              vertical(10),
              boldtext(
                  Ccolor.textblack, 12, "SALARY : ${widget.data['salary']}"),
              vertical(10),
              boldtext(Ccolor.textblack, 12,
                  "MARITAL STATUS : ${widget.data['maritalstatus']}"),
              vertical(10),
              boldtext(Ccolor.textblack, 12, "HOUSE : ${widget.data['house']}"),
              vertical(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  boldtext(Ccolor.textblack, 12, "CHILDREN"),
                  vertical(5),
                  ViewChildrensWidget(docid: widget.docid),
                ],
              ),
              vertical(10),
              boldtext(
                  Ccolor.textblack, 12, "ADDRESS : ${widget.data['address']}"),
              vertical(10),
              boldtext(
                  Ccolor.textblack,
                  12,
                  widget.data['alive'] == null
                      ? "ALIVE : YES"
                      : "ALIVE : ${widget.data['alive']}"),
              vertical(15),
              widget.data['alive'] == "NO"
                  ? Column(
                      children: [
                        boldtext(Ccolor.textblack, 13, "Death Certificate"),
                        Image.network(widget.data['deathimgurl'])
                      ],
                    )
                  : const SizedBox.shrink(),
              vertical(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  boldtext(Ccolor.textblack, 12,
                      "ANY CHRONIC AILMENT TO ANY FAMILY MEMBER"),
                  vertical(5),
                  boldtext(Ccolor.textblack, 12,
                      "DETAILS : ${widget.data['details']}"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
