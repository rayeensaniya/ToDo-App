import 'package:intl/intl.dart';

class FormatarUtils{
 static String dateFormatted(DateTime dateTime){
   final formatDate= DateFormat('dd/MM/yyyy');
  final date = formatDate.format(dateTime);

    return date;
  }

}