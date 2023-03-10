import 'dart:ui';

import 'package:flutter/material.dart';

// class BlurryDialog extends StatelessWidget {
//   VoidCallback continueCallBack;

//   BlurryDialog(this.continueCallBack);
//   TextStyle textStyle = TextStyle(color: Colors.black);

//   @override
//   Widget build(BuildContext context) {
//     return showDialog(
//       context: context,
//       child: AlertDialog(
//         content: Text(
//           'Do you wants to delete',
//           style: textStyle,
//         ),
//         actions: <Widget>[
//         ],
//       ),
//     );
//   }
// }
showDelete(context, VoidCallback continueCallBack) async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Icon(
        Icons.warning_amber_rounded,
        color: Colors.red,
        size: 50,
      ),
      content: Text('Do you want to delete.'),
      actions: <Widget>[
        ElevatedButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: new Text("Delete"),
          onPressed: () {
            continueCallBack();
          },
        ),
      ],
    ),
  );
}
