import 'package:flutter/material.dart';

import 'formattor.dart';

class AppDialog {
  static Future<String?> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2500),
    );
    final formattedDate = FormatarUtils.dateFormatted(picked!);
    return formattedDate;
  }
}
