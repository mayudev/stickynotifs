import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:stickynotifs/models/state.dart';
import 'package:stickynotifs/pages/details.dart';
import 'package:stickynotifs/util/notes.dart';
import 'package:stickynotifs/util/notification_mode.dart';

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

      showNoteNotification(
          note, DateTime.fromMillisecondsSinceEpoch(note.createdAt));
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

  NotificationsService._internal();
}
