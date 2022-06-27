import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationChannel {
  final NotificationDetails value;

  const NotificationChannel(this.value);

  static NotificationChannel sticky = wrap(const AndroidNotificationDetails(
      'sticky', 'Sticky Notifications',
      priority: Priority.high, ongoing: true));
}

NotificationChannel wrap(AndroidNotificationDetails channel) {
  return NotificationChannel(NotificationDetails(android: channel));
}
