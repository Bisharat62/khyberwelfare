import 'package:flutter/material.dart';
import 'package:khyberwelfareforum/src/components/appbar.dart';
import 'package:khyberwelfareforum/src/helpers/color.dart';
import 'package:khyberwelfareforum/src/helpers/const_text.dart';
import 'package:khyberwelfareforum/src/screens/authentication/signup.dart';
import 'package:khyberwelfareforum/src/screens/pages/accounts/view_all_accounts.dart';

import '../../../components/assets.dart';
import '../../../components/widgets_homepage.dart';
import 'add_commite_members.dart';

class AccountsScreen extends StatelessWidget {
  AccountsScreen({super.key});
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ViewAllAccountsScreen()));
          },
          label: boldtext(Ccolor.textblack, 14, "View all Accounts")),
      appBar: Appbar(
        globalKey: _key,
        title: "Create Accounts",
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
              text: "ADMIN",
              img: IMAGES.COORDINATOR,
              navigator: SignUpScreen(
                create: true,
                title: "Admin",
              ),
            ),
            ContainerCard(
              text: "COORDINATOR",
              img: IMAGES.COORDINATOR,
              navigator: SignUpScreen(
                create: true,
                title: "Coordinator",
              ),
            ),
            ContainerCard(
              text: "FOCAL PERSON",
              img: IMAGES.FOCAL_PERSON,
              navigator: SignUpScreen(
                create: true,
                title: "Focal Person",
              ),
            ),
            ContainerCard(
              text: "MEMBERS",
              img: IMAGES.MEMBER,
              navigator: SignUpScreen(
                create: true,
                title: "Create Member",
              ),
            ),
            ContainerCard(
              text: "HOSPITAL FOCAL PERSON",
              img: IMAGES.FOCAL_PERSON,
              navigator: SignUpScreen(
                create: true,
                title: "HospitalFocalPerson",
              ),
            ),
            ContainerCard(
              text: "ACCOUNTANT / TREASURE ",
              img: IMAGES.FOCAL_PERSON,
              navigator: SignUpScreen(
                create: true,
                title: "accountant/treasure",
              ),
            ),
            ContainerCard(
              text: "ADD COMMITEE MEMBERS",
              img: IMAGES.FOCAL_PERSON,
              navigator: const AddCommiteeMem(),
            ),
          ],
        ),
      ),
    );
  }
}
