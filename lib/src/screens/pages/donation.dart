import 'package:flutter/material.dart';
import 'package:khyberwelfareforum/src/components/appbar.dart';
import 'package:khyberwelfareforum/src/components/assets.dart';
import 'package:khyberwelfareforum/src/helpers/button.dart';
import 'package:khyberwelfareforum/src/screens/pages/controlldonations/controlldonation.dart';

import '../../components/globals.dart';

class DonationsScreen extends StatelessWidget {
  DonationsScreen({super.key});

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        globalKey: _key,
        title: "Accounts",
        back: true,
      ), //accounts
      body: SingleChildScrollView(
        child: Column(
          children: [
            (USERROLE == "Admin" || USERROLE == "accountant/treasure")
                ? Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: buttonmain(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ControllDonations()));
                    }, "CONTROL DONATIONS", 0.9, context),
                  )
                : const SizedBox.shrink(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                IMAGES.ACCOUNTSDETAILS,
                fit: BoxFit.fill,
              ),
            )
          ],
        ),
      ),
    );
  }
}
