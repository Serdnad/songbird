import 'package:flutter/material.dart';

class AlertHelper {
  static void showPrompt(
      BuildContext context, String title, String message, VoidCallback action) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  action();
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        });
  }
}
