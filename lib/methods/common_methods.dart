


import 'package:intl/intl.dart';

import '../ themes/constants.dart';

String capitalize(String string)
{
  return string[0].toUpperCase()+string.substring(1);
}

String dateString(DateTime date)
{
  return '${date.day} ${month[date.month]!} , ${date.year}' ;
}

String dateTimeString(DateTime date)
{
  var f=NumberFormat('#00.##');
  String ampm=date.hour<12?'am':'pm';
  return capitalize('${month[date.month]!} ${date.day} ,${date.year} (${date.hour%12==0?12:date.hour%12}:${f.format(date.minute)} $ampm)') ;
}