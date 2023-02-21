import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';

class Tools {
  static String prettierJson(
    Map<String, dynamic> json, {
    bool enableLog = true,
  }) {
    final String prettyString =
        const JsonEncoder.withIndent('  ').convert(json);

    if (enableLog) {
      log(prettyString);
    }
    return prettyString;
  }

  static textCpy(BuildContext context, String text) {
    try {
      EasyLoading.show(status: '');
      Clipboard.setData(ClipboardData(text: text)).then((_) {
        return Flushbar(
          borderRadius: BorderRadius.circular(50),
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          flushbarStyle: FlushbarStyle.FLOATING,
          flushbarPosition: FlushbarPosition.BOTTOM,
          animationDuration: const Duration(milliseconds: 500),
          duration: const Duration(milliseconds: 800),
          backgroundColor: Colors.green,
          message: "Content has been copied.",
          messageSize: 12,
        ).show(context);
      });
      EasyLoading.dismiss();
    } catch (err) {
      EasyLoading.dismiss();
    }
  }
}
