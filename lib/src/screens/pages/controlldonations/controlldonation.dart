import 'package:flutter/material.dart';
import 'package:khyberwelfareforum/src/components/appbar.dart';
import 'package:khyberwelfareforum/src/helpers/button.dart';
import 'package:khyberwelfareforum/src/screens/pages/controlldonations/add_expenses.dart';
import 'package:khyberwelfareforum/src/screens/pages/controlldonations/totalbudget.dart';
import 'package:khyberwelfareforum/src/screens/pages/controlldonations/view_donations.dart';
import 'package:khyberwelfareforum/src/screens/pages/controlldonations/view_expenses.dart';

import '../../../components/assets.dart';
import '../../../components/widgets_homepage.dart';

class ControllDonations extends StatelessWidget {
  ControllDonations({super.key});

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        globalKey: _key,
        title: "Donation Details",
        back: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Wrap(
            runSpacing: 20,
            alignment: WrapAlignment.spaceEvenly,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ContainerCard(
                text: " DONATIONS",
                img: IMAGES.DONATION,
                navigator: const ViewDonationScreen(),
              ),
              ContainerCard(
                text: "EXPENDITURE",
                img: IMAGES.EXPENSES,
                navigator: const ViewExpensesScreen(),
              ),
              ContainerCard(
                text: "TOTAL BUDGET",
                img: IMAGES.BUDGET,
                navigator: TotalBudget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
