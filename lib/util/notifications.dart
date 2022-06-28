import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:stickynotifs/models/state.dart';
import 'package:stickynotifs/pages/details.dart';
import 'package:stickynotifs/util/notes.dart';
import 'package:stickynotifs/util/notification_mode.dart';
// ignore: depend_on_referenced_packages
import 'package:timezone/data/latest.dart' as tz;
// ignore: depend_on_referenced_packages
import 'package:timezone/timezone.dart' as tz;

class NotificationsService {
  final FlutterLocalNotificationsPlugin plugin =
      FlutterLocalNotificationsPlugin();

  static final NotificationsService _notificationsService =
      NotificationsService._internal();

  factory NotificationsService() {
    return _notificationsService;
  }

  Future<void> init(BuildContext context) async {
    const androidSettings = AndroidInitializationSettings('ic_launcher');
    // TODO use an actual icon (i'll probably never actually make it because nobody will use this app anyway)

    const initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: null,
      macOS: null,
      linux: null,
    );

    tz.initializeTimeZones();

    await plugin.initialize(initializationSettings,
        onSelectNotification: (payload) => onSelect(context, payload));
  }

  void onSelect(BuildContext context, String? payload) {
    final id = int.tryParse(payload!);

    if (id != null) {
      Navigator.pushNamed(context, DetailsPage.routeName,
          arguments: DetailsPageArguments(id));

      /// Respawn the notification
      final notes = context.read<NoteModel>();
      final note = notes.items.firstWhere((element) => element.id == id);

      final date =
          note.remindAt == 0 ? note.createdAt : note.remindAt ?? note.createdAt;
      showNoteNotification(note, DateTime.fromMillisecondsSinceEpoch(date));
    }
  }

  Future<NotificationAppLaunchDetails?> launchDetails() async {
    return await plugin.getNotificationAppLaunchDetails();
  }

  /// Show a notification with specified parameters
  void show(int id, String title, String body, NotificationChannel channel) {
    plugin.show(
      id,
      title,
      body,
      channel.value,
      payload: id.toString(),
    );
  }

  /// Cancel a notification by ID
  void cancel(int id) {
    plugin.cancel(id);
  }

  /// Schedule a notification
  void schedule(int id, String title, String body, int timestamp,
      NotificationChannel channel) {
    plugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.fromMillisecondsSinceEpoch(tz.local, timestamp),
        channel.value,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        payload: id.toString());
  }

  NotificationsService._internal();
}
