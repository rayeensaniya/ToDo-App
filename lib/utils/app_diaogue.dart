import 'package:flutter/material.dart';
import 'package:todo_app/modals/date_modal.dart';

import 'formattor.dart';

class AppDialog {
  static Future<DateModal?> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2500),
    );
    final formattedDate = FormatarUtils.dateFormatted(picked!);
    return DateModal(
        formattedDate: formattedDate,
        unFormatted: picked.toString(),
        utc: picked.toUtc().toString(),
        iso: picked.toIso8601String(),
        yymmdd: FormatarUtils.dateFormatted(picked, 'dd MMM yyyy hh:mm a'));
  }
}
