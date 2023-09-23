import 'package:intl/intl.dart';

extension AppDateTimeFormatter on DateTime {
  String toRelativeDate(String format) {
    final DateFormat dateFormat = DateFormat(format);
    final DateTime now = DateTime.now();
    final Duration difference = now.difference(this);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inHours >= 2 && difference.inDays == 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1 && difference.inDays == 0) {
      return 'An hour ago';
    } else if (difference.inMinutes >= 2 && difference.inDays == 0) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1 && difference.inDays == 0) {
      return '1 minute ago';
    } else if (difference.inSeconds >= 3 && difference.inDays == 0) {
      return 'Just now';
    }

    return dateFormat.format(this);
  }
}
