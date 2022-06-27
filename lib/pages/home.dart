import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stickynotifs/models/state.dart';
import 'package:stickynotifs/util/notifications.dart';
import 'package:stickynotifs/widgets/heading.dart';
import 'package:stickynotifs/widgets/input.dart';
import 'package:stickynotifs/widgets/note_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NotificationsService().init(context);

    NotificationsService().launchDetails().then((details) {
      print('${details?.didNotificationLaunchApp}');
      print('${details?.payload}');
    });

    return Scaffold(
      appBar: AppBar(title: const Text('StickyNotifs')),
      body: GestureDetector(
        onTap: () {
          // Clear focus
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          children: const [
            NoteInput(),
            Heading(text: 'Current notes'),
            NoteList(),
          ],
        ),
      ),
    );
  }
}
