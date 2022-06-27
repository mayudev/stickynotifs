import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:stickynotifs/util/notification_mode.dart';

class NotificationsService {
  final FlutterLocalNotificationsPlugin plugin =
      FlutterLocalNotificationsPlugin();

  static final NotificationsService _notificationsService =
      NotificationsService._internal();

  factory NotificationsService() {
    return _notificationsService;
  }

  Future<void> init() async {
    const androidSettings = AndroidInitializationSettings('ic_launcher');
    // TODO use an actual icon (i'll probably never actually make it because nobody will use this app anyway)

    const initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: null,
      macOS: null,
      linux: null,
    );

    await plugin.initialize(initializationSettings);
  }

  /// Show a notification with specified parameters
  void show(int id, String title, String body, NotificationChannel channel) {
    plugin.show(
      id,
      title,
      body,
      channel.value,
    );
  }

  // Cancel a notification by ID
  void cancel(int id) {
    plugin.cancel(id);
  }

  NotificationsService._internal();
}
