import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void showAlertDialog(BuildContext context, String message) {
  showDialog(
    context: context, 
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.all(20),
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
      );
  });
}