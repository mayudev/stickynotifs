import 'package:flutter/material.dart';
import 'package:stickynotifs/pages/create.dart';
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
      if (details != null &&
          details.payload != null &&
          details.didNotificationLaunchApp &&
          details.payload!.isNotEmpty) {
        NotificationsService().onSelect(context, details.payload);
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('StickyNotifs')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, CreatePage.routeName);
        },
      ),
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
            NoteList(
              current: true,
            ),
            Heading(text: 'Pending notes'),
            NoteList(current: false)
          ],
        ),
      ),
    );
  }
}
