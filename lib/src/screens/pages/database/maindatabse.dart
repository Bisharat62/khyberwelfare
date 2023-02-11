import 'package:flutter/material.dart';
import 'package:khyberwelfareforum/src/components/appbar.dart';
import 'package:khyberwelfareforum/src/screens/pages/database/database_add.dart';

import '../../../components/assets.dart';
import '../../../components/widgets_homepage.dart';

class MainDatabaseScreen extends StatelessWidget {
  MainDatabaseScreen({super.key});

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        globalKey: _key,
        title: "Database",
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
                text: "Create Database",
                img: IMAGES.DATABASE_ADD,
                navigator: const DatabaseAddScreen(),
              ),
              ContainerCard(
                text: "View Database",
                img: IMAGES.DATABASE_VIEW,
              ),
              ContainerCard(
                text: "Created By Me",
                img: IMAGES.DATABASE_ADDBYME,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
