import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khyberwelfareforum/src/components/appbar.dart';
import 'package:khyberwelfareforum/src/components/assets.dart';
import 'package:khyberwelfareforum/src/components/drawer.dart';
import 'package:khyberwelfareforum/src/components/globals.dart';
import 'package:khyberwelfareforum/src/components/widgets_homepage.dart';
import 'package:khyberwelfareforum/src/helpers/spacer.dart';
import 'package:khyberwelfareforum/src/screens/pages/accounts/accounts_main.dart';
import 'package:khyberwelfareforum/src/screens/pages/database/maindatabse.dart';
import 'package:khyberwelfareforum/src/screens/pages/requests.dart';

import 'donation.dart';
import 'formsubmission/form.dart';

class HomepageScreen extends StatelessWidget {
  const HomepageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
    DateTime? currentBackPressTime;
    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (currentBackPressTime == null ||
            now.difference(currentBackPressTime!) > Duration(seconds: 4)) {
          currentBackPressTime = now;
          const snack = SnackBar(
            backgroundColor: Colors.red,
            content: Text('Press Back button again to Exit'),
            duration: Duration(seconds: 4),
          );
          ScaffoldMessenger.of(context).showSnackBar(snack);
          return Future.value(false);
        } else {
          SystemNavigator.pop();
          return Future.value(true);
        }
      },
      child: Scaffold(
        key: _key,
        backgroundColor: Colors.white,
        appBar: Appbar(
          globalKey: _key,
          title: "",
        ),
        drawer: const DrawerMain(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 160, child: Image.asset(IMAGES.LOGO)),
                vertical(25),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Wrap(
                    runSpacing: 20,
                    alignment: WrapAlignment.spaceEvenly,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: <Widget>[
                      (USERROLE == "Admin")
                          ? ContainerCard(
                              text: "ACCOUNTS",
                              img: IMAGES.ACCOUNTS,
                              navigator: AccountsScreen(),
                            )
                          : const SizedBox.shrink(),
                      ContainerCard(
                        text: "MEDICAL AID COMMITTEE",
                        img: IMAGES.MEDICAL,
                        navigator: ShowHelpFormScreen(
                          title: "Medical Help",
                          committee: "medical",
                        ),
                      ),
                      ContainerCard(
                        text: "LEGAL AID COMMITTEE",
                        img: IMAGES.LEGAL,
                        navigator: ShowHelpFormScreen(
                          title: "Legal Help",
                          committee: "legal",
                        ),
                      ),
                      ContainerCard(
                        text: "EDUCATION COMMITTEE",
                        img: IMAGES.EDUCATION,
                        navigator: ShowHelpFormScreen(
                          title: "Education Help",
                          committee: "education",
                        ),
                      ),
                      ContainerCard(
                        text: "EMPLOYMENT COMMITTEE",
                        img: IMAGES.EMPLOYMENT,
                        navigator: ShowHelpFormScreen(
                          title: "Employment Help",
                          committee: "employment",
                        ),
                      ),
                      ContainerCard(
                        text: "DONATIONS",
                        img: IMAGES.DONATIONS,
                        navigator: DonationsScreen(),
                      ),
                      (USERROLE.toString().toLowerCase().contains("member"))
                          ? const SizedBox.shrink()
                          : ContainerCard(
                              text: "REQUESTS",
                              img: IMAGES.REQUEST,
                              navigator: const RequestsScreen(),
                            ),
                      (USERROLE.toString().toLowerCase().contains("member"))
                          ? const SizedBox.shrink()
                          : ContainerCard(
                              text: "DATABASE",
                              img: IMAGES.DATABASE,
                              navigator: MainDatabaseScreen(),
                            ),
                    ],
                  ),
                ),
                vertical(25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
