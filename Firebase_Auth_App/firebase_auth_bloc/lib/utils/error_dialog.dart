import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/custom_error.dart';

void errorDialog(BuildContext context, CustomError e) {
  print('code : ${e.code}\nmessage : ${e.message}\nplugin : ${e.plugin}\n');
  if (Platform.isIOS) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(e.code),
          content: Text(e.plugin + '\n' + e.message),
          actions: [
            CupertinoDialogAction(
              child: Text('Ok'),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      },
    );
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(e.code),
          content: Text(e.plugin + '\n' + e.message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
