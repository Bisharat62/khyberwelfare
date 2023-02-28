import 'package:flutter/material.dart';

import '../../../components/appbar.dart';
import '../../../components/assets.dart';
import '../../../components/widgets_homepage.dart';
import 'add_details.dart';

class AddCommiteeMem extends StatefulWidget {
  const AddCommiteeMem({super.key});

  @override
  State<AddCommiteeMem> createState() => _AddCommiteeMemState();
}

class _AddCommiteeMemState extends State<AddCommiteeMem> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        globalKey: _key,
        title: "Create Commite Members",
        back: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Wrap(
          spacing: 20,
          runSpacing: 20,
          alignment: WrapAlignment.spaceEvenly,
          children: [
            ContainerCard(
              text: "MEDICAL AID COMMITTEE",
              img: IMAGES.MEDICAL,
              navigator: AddDetailsCimmiteeMembers(
                title: "medical",
              ),
            ),
            ContainerCard(
              text: "LEGAL AID COMMITTEE",
              img: IMAGES.LEGAL,
              navigator: AddDetailsCimmiteeMembers(
                title: "legal",
              ),
            ),
            ContainerCard(
              text: "EDUCATION COMMITTEE",
              img: IMAGES.EDUCATION,
              navigator: AddDetailsCimmiteeMembers(
                title: "education",
              ),
            ),
            ContainerCard(
              text: "EMPLOYMENT COMMITTEE",
              img: IMAGES.EMPLOYMENT,
              navigator: AddDetailsCimmiteeMembers(
                title: "employment",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
