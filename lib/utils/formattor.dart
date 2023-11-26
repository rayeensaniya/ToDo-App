import 'package:intl/intl.dart';

class FormatarUtils {
  static String dateFormatted(DateTime dateTime,
      [String? formate = 'dd MMM yyyy hh:mm a']) {
    final formatDate = DateFormat(formate);
    final date = formatDate.format(dateTime);

    return date;
  }
}