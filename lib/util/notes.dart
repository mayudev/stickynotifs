import 'dart:io';

import 'package:intl/intl.dart';
import 'package:stickynotifs/models/note.dart';
import 'package:stickynotifs/util/notification_mode.dart';
import 'package:stickynotifs/util/notifications.dart';

void showNoteNotification(Note note, DateTime now) {
  final time = DateFormat.jm(Platform.localeName).format(now);

  NotificationsService().show(
      note.id ?? 0, note.content, 'Today at $time', NotificationChannel.sticky);
}

void scheduleNotification(Note note, int remindAt) {
  final time = DateFormat.jm(Platform.localeName)
      .format(DateTime.fromMillisecondsSinceEpoch(remindAt));

  NotificationsService().schedule(note.id ?? 0, note.content, 'Today at $time',
      remindAt, NotificationChannel.sticky);
}

void handleNotification(Note note, DateTime now, int remindAt) {
  final nowMS = now.millisecondsSinceEpoch;

  if (remindAt > nowMS) {
    NotificationsService().cancel(note.id!);
    scheduleNotification(note, remindAt);
  } else {
    showNoteNotification(note, now);
  }
}
