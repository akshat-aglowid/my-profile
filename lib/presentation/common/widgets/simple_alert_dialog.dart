import 'package:flutter/material.dart';

class SimpleAlertDialog {
  final BuildContext context;
  final String title;
  final String message;
  String okText;
  final VoidCallback onPressedOk;

  SimpleAlertDialog(
      {required this.context,
      this.title = "",
      required this.message,
      this.okText = "OK",
      required this.onPressedOk});

  show() {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text(title),
        content: Text(message),
        actions: <Widget>[
          new TextButton(
            onPressed: () {
              Navigator.pop(context);
              onPressedOk();
            },
            child: new Text(okText),
          )
        ],
      ),
    );
  }
}
