import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nytimes/utils/context_extension.dart';

extension AppDateTimeFormatter on DateTime {
  String toRelativeDate(String format, {BuildContext? context}) {
    final DateFormat dateFormat = DateFormat(format);
    final DateTime now = DateTime.now();
    final Duration difference = now.difference(this);

    if (difference.inDays == 0) {
      return context?.localization.today ?? 'Today';
    } else if (difference.inDays == 1) {
      return context?.localization.yesterday ?? 'Yesterday';
    } else if (difference.inHours >= 1 && difference.inDays == 0) {
      return context?.localization.hoursAgo(difference.inHours) ??
          '${difference.inHours} hours ago';
    } else if (difference.inMinutes >= 1 && difference.inDays == 0) {
      return context?.localization.minutesAgo(difference.inMinutes) ??
          '${difference.inHours} minutes ago';
    } else if (difference.inSeconds >= 3 && difference.inDays == 0) {
      return context?.localization.justNow ?? 'Just now';
    }

    return dateFormat.format(this);
  }
}
