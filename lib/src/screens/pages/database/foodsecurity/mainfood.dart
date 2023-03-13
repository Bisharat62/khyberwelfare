import 'package:flutter/material.dart';
import 'package:khyberwelfareforum/src/components/network/firebase/collection_names.dart';
import 'package:khyberwelfareforum/src/screens/pages/database/foodsecurity/view_food_security.dart';

import '../../../../components/appbar.dart';
import '../../../../components/assets.dart';
import '../../../../components/widgets_homepage.dart';
import '../../../../helpers/button.dart';
import '../../../../helpers/spacer.dart';
import 'add_database_food.dart';

class MainFoodSecurity extends StatefulWidget {
  const MainFoodSecurity({super.key});

  @override
  State<MainFoodSecurity> createState() => _MainFoodSecurityState();
}

class _MainFoodSecurityState extends State<MainFoodSecurity> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        globalKey: _key,
        title: "Food Security",
        back: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Wrap(
            // spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.spaceEvenly,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ContainerCard(
                text: "Add Database",
                img: IMAGES.DATABASE_ADD,
                ontap: () {
                  showadd();
                },
              ),
              ContainerCard(
                text: "View Database",
                img: IMAGES.DATABASE_VIEW,
                ontap: () {
                  showview();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  showadd() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buttonmain(() {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddFoodSecurity(
                              title: 'ORPHANS DATABASE',
                              collectionName: CollectionNames.ORPHANS,
                            )));
              }, 'ADD ORPHAN', 0.5, context),
              buttonmain(() {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddFoodSecurity(
                              title: 'WIDOW DATABASE',
                              collectionName: CollectionNames.WIDOW,
                            )));
              }, 'ADD WIDOW', 0.5, context),
              buttonmain(() {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddFoodSecurity(
                              title: 'DISABLED DATABASE',
                              collectionName: CollectionNames.DISABLED,
                            )));
              }, 'ADD DISABLED', 0.5, context),
              vertical(15),
            ],
          ),
        ),
        // content: Text('Do you want to delete.'),
        actions: <Widget>[
          ElevatedButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  showview() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buttonmain(() {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewFoodSecurity(
                              title: 'ORPHANS DATABASE',
                              collectionName: CollectionNames.ORPHANS,
                            )));
              }, 'VIEW ORPHAN', 0.5, context),
              buttonmain(() {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewFoodSecurity(
                              title: 'WIDOW DATABASE',
                              collectionName: CollectionNames.WIDOW,
                            )));
              }, 'VIEW WIDOW', 0.5, context),
              buttonmain(() {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewFoodSecurity(
                              title: 'DISABLED DATABASE',
                              collectionName: CollectionNames.DISABLED,
                            )));
              }, 'VIEW DISABLED', 0.5, context),
              vertical(15),
            ],
          ),
        ),
        // content: Text('Do you want to delete.'),
        actions: <Widget>[
          ElevatedButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
