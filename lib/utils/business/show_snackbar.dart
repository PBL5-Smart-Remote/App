import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void showSnackBar(BuildContext context, String title, String message, ContentType contentType) {
  // final materialBanner = MaterialBanner(
  //   /// need to set following properties for best effect of awesome_snackbar_content
  //   elevation: 0,
  //   backgroundColor: Colors.transparent,
  //   forceActionsBelow: true,
  //   content: AwesomeSnackbarContent(
  //     title: title,
  //     message: message,
  //     /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
  //     contentType: contentType,
  //     // to configure for material banner
  //     inMaterialBanner: true,
  //   ),
  //   actions: const [SizedBox.shrink()],
  // );

  // ScaffoldMessenger.of(context)
  //   ..hideCurrentMaterialBanner()
  //   ..showMaterialBanner(materialBanner);

  final snackBar = SnackBar(
    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title,
      message: message,

      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
      contentType: contentType,
    ),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}