import 'package:flutter/material.dart';
import 'package:khyberwelfareforum/src/helpers/spacer.dart';
import 'package:khyberwelfareforum/src/screens/authentication/signin.dart';
import 'package:khyberwelfareforum/src/screens/pages/controlldonations/add_donations.dart';
import 'package:khyberwelfareforum/src/screens/pages/drawerscreens/profilescreen.dart';
import 'package:khyberwelfareforum/src/screens/pages/homepage.dart';
import 'package:khyberwelfareforum/src/screens/pages/treatment/add_details_treatment.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/color.dart';
import '../helpers/const_text.dart';
import '../screens/pages/add_donation_accounts.dart';
import '../screens/pages/drawerscreens/changepass.dart';
import '../screens/pages/treatment/view_details_treatment.dart';
import 'globals.dart';

class DrawerMain extends StatelessWidget {
  const DrawerMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          vertical(80),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Ccolor.btnbg,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomepageScreen()));
            },
            title: boldtext(Ccolor.textblack, 14, 'Home'),
          ),
          ListTile(
            leading: Icon(
              Icons.person_outlined,
              color: Ccolor.btnbg,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()));
            },
            title: boldtext(Ccolor.textblack, 14, 'Profile'),
          ),
          (USERROLE == "Admin")
              ? ListTile(
                  leading: Icon(
                    Icons.add_task_rounded,
                    color: Ccolor.btnbg,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddDonationAccount()));
                  },
                  title: boldtext(Ccolor.textblack, 14, 'Add Donation Details'),
                )
              : const SizedBox.shrink(),
          (USERROLE == "Admin" || USERROLE == "HospitalFocalPerson")
              ? ListTile(
                  leading: Icon(
                    Icons.person_outlined,
                    color: Ccolor.btnbg,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddTreatment()));
                  },
                  title:
                      boldtext(Ccolor.textblack, 14, 'Add Treatment Details'),
                )
              : const SizedBox.shrink(),
          (USERROLE == "Admin" || USERROLE == "HospitalFocalPerson")
              ? ListTile(
                  leading: Icon(
                    Icons.person_outlined,
                    color: Ccolor.btnbg,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ViewDetailsTreatment()));
                  },
                  title:
                      boldtext(Ccolor.textblack, 14, 'View Treatment Details'),
                )
              : const SizedBox.shrink(),
          ListTile(
            leading: Icon(
              Icons.lock_reset_rounded,
              color: Ccolor.btnbg,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ChangePassScreen()));
            },
            title: boldtext(Ccolor.textblack, 14, 'Change Password'),
          ),
          ListTile(
            leading: const Icon(
              Icons.logout_outlined,
              color: Colors.red,
            ),
            onTap: () {
              delete_saved_login();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignInScreen()));
            },
            title: boldtext(Colors.red, 14, 'Logout'),
          ),
        ],
      ),
    );
  }
}

delete_saved_login() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.clear();
}
