import 'dart:convert';
import 'dart:developer';

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
}
