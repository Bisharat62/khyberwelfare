import 'package:flutter/material.dart';
import 'package:khyberwelfareforum/src/components/assets.dart';
import 'package:khyberwelfareforum/src/components/widgets_homepage.dart';
import 'package:khyberwelfareforum/src/helpers/spacer.dart';
import 'package:khyberwelfareforum/src/screens/pages/accounts/accounts_main.dart';

class HomepageScreen extends StatelessWidget {
  const HomepageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Image.asset(IMAGES.LOGO),
            vertical(25),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.spaceEvenly,
              children: <Widget>[
                ContainerCard(
                  text: "ACCOUNTS",
                  img: IMAGES.ACCOUNTS,
                  navigator: const AccountsScreen(),
                ),
                ContainerCard(
                  text: "MEDICAL AID COMMITTEE",
                  img: IMAGES.MEDICAL,
                ),
                ContainerCard(
                  text: "LEGAL AID COMMITTEE",
                  img: IMAGES.LEGAL,
                ),
                ContainerCard(
                  text: "EDUCATION COMMITTEE",
                  img: IMAGES.EDUCATION,
                ),
                ContainerCard(
                  text: "EMPLOYMENT COMMITTEE",
                  img: IMAGES.EMPLOYMENT,
                ),
                ContainerCard(
                  text: "DONATIONS",
                  img: IMAGES.DONATIONS,
                ),
                ContainerCard(
                  text: "DATABASE",
                  img: IMAGES.DATABASE,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
