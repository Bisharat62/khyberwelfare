import 'package:flutter/material.dart';
import 'package:khyberwelfareforum/src/components/network/signin_network.dart';
import 'package:khyberwelfareforum/src/screens/authentication/signup.dart';
import 'package:khyberwelfareforum/src/components/assets.dart';

import '../../components/network/chechinternet.dart';
import '../../helpers/button.dart';
import '../../helpers/color.dart';
import '../../helpers/const_text.dart';
import '../../helpers/spacer.dart';
import '../../helpers/text_decor.dart';
import '../pages/homepage.dart';
import 'forgotpass.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({
    super.key,
  });

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  bool first = false;
  bool second = false;
  bool loader = true;
  @override
  Widget build(BuildContext context) {
    totalheight = MediaQuery.of(context).size.height;
    // print(widget.selected);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(IMAGES.LOGO),
              boldtext(Ccolor.textblack, 25, 'Sign In'),
              vertical(10),
              mediumtext(Ccolor.texthint, 18,
                  'SignIn into account to access full version with all features'),
              vertical(50),
              textarea(email, 'Email*'),
              textarea(pass, 'Password*'),
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotpassScreen()));
                      },
                      child: boldtext(Colors.red, 12, "Forgot Password ?"))),
              vertical(20),
              buttonmain(() {
                if (email.text.isEmpty || pass.text.isEmpty) {
                  showInSnackBar('Please Fill All fields', color: Colors.red);
                } else {
                  signin(context, {"email": email.text, "pass": pass.text});
                }
              }, 'Sign In', 1.0, context),
              vertical(20),
              newuser(
                  context, "Dont't have an account", 'Sing Up', SignUpScreen())
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
}
