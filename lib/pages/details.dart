import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stickynotifs/models/note.dart';
import 'package:stickynotifs/models/state.dart';
import 'package:stickynotifs/theme.dart';
import 'package:stickynotifs/widgets/heading.dart';

class DetailsPageArguments {
  final int id;

  DetailsPageArguments(this.id);
}

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  static const routeName = '/details';

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  DetailsPageArguments args(BuildContext context) {
    return ModalRoute.of(context)!.settings.arguments as DetailsPageArguments;
  }

  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void delete(BuildContext context) {
    pop(context);

    final notes = Provider.of<NoteModel>(context, listen: false);
    notes.remove(args(context).id);
  }

  void pop(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    try {
      final model = context.watch<NoteModel>();
      final note = model.getNoteById(args(context).id);

      _controller.text = note.content;

      return Scaffold(
        appBar: AppBar(
          title: const Text('Note'),
          actions: [
            IconButton(
                onPressed: () {
                  delete(context);
                },
                tooltip: 'Delete',
                icon: const Icon(Icons.delete, color: Colors.black))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final newNote = Note(
                id: note.id!,
                content: _controller.text,
                createdAt: note.createdAt,
                remindAt: note.remindAt,
                updatedAt: note.updatedAt);

            model.updateNote(note.id!, newNote);
          },
          child: const Icon(Icons.edit),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
                label: Text('Note...'),
              ),
              style: const TextStyle(
                fontSize: 18.0,
              ),
              maxLines: null,
            ),
            ListTile(
              title: const Text('Added'),
              subtitle: Text(parseTime(note.createdAt)),
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.event_available),
                ],
              ),
            ),
            ListTile(
              title: const Text('Scheduled'),
              subtitle: Text(parseTime(note.remindAt)),
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.schedule),
                ],
              ),
            )
          ],
        ),
      );
    } on StateError {
      // fun
      return Container();
    }
  }

  String parseTime(int? timestamp) {
    if (timestamp == null) return 'Unknown';
    if (timestamp == 0) {
      return 'Now';
    } else {
      return DateFormat.yMMMd()
          .add_jm()
          .format(DateTime.fromMillisecondsSinceEpoch(timestamp));
    }
  }
}
