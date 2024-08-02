import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomCupertinoAlertDialog {
  CupertinoAlertDialog _createAlertDialog(
      {required BuildContext context,
      required String title,
      required String content}) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        CupertinoDialogAction(
          child: const Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  void showAlert(
      {required BuildContext context,
      required String title,
      required String content}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return _createAlertDialog(
              context: context, title: title, content: content);
        });
  }
}
