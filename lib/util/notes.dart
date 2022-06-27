import 'package:intl/intl.dart';
import 'package:stickynotifs/models/note.dart';
import 'package:stickynotifs/util/notification_mode.dart';
import 'package:stickynotifs/util/notifications.dart';

void showNoteNotification(Note note, DateTime now) {
  final time = DateFormat("HH:mm").format(now);

  NotificationsService().show(
      note.id ?? 0, note.content, 'Today at $time', NotificationChannel.sticky);
}
