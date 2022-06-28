import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stickynotifs/models/note.dart';
import 'package:stickynotifs/models/state.dart';

class CreatePageArguments {
  final int? editingId;

  CreatePageArguments(this.editingId);
}

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  static const routeName = '/create';

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  CreatePageArguments? args(BuildContext context) {
    return ModalRoute.of(context)!.settings.arguments as CreatePageArguments?;
  }

  final _content = TextEditingController();

  bool immediate = false;
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  Note? initialNote;

  @override
  void dispose() {
    _content.dispose();
    super.dispose();
  }

  void addNote() {
    final value = _content.text;

    var notes = Provider.of<NoteModel>(context, listen: false);

    int remindAt = computeTimestamp();

    notes.add(value, remindAt: remindAt);
    Navigator.pop(context);
  }

  void updateNote() {
    final newNote = Note(
        id: initialNote!.id!,
        content: _content.text,
        createdAt: initialNote!.createdAt,
        updatedAt: DateTime.now().millisecondsSinceEpoch,
        remindAt: computeTimestamp());

    final notes = Provider.of<NoteModel>(context, listen: false);

    notes.updateNote(initialNote!.id!, newNote);
    Navigator.pop(context);
  }

  void deleteNote() {
    Navigator.pop(context);

    final notes = Provider.of<NoteModel>(context, listen: false);
    notes.remove(initialNote!.id!);
  }

  @override
  Widget build(BuildContext context) {
    final int? editingId = args(context)?.editingId;
    final bool isEditing = editingId != null;

    try {
      if (isEditing && initialNote == null) {
        Note note;

        final model = context.watch<NoteModel>();
        note = model.getNoteById(editingId);

        _content.value = TextEditingValue(
            text: note.content,
            selection: TextSelection.collapsed(offset: note.content.length));

        if (note.remindAt == null || note.remindAt == 0) {
          immediate = true;
        } else {
          date = DateTime.fromMillisecondsSinceEpoch(note.remindAt!);
          time = TimeOfDay.fromDateTime(date);
        }

        initialNote = note;
      }
    } catch (e) {}

    return Scaffold(
        appBar: AppBar(
          title: Text(isEditing ? 'Edit note' : 'Create a new note'),
          actions: isEditing
              ? [
                  IconButton(
                      onPressed: () {
                        deleteNote();
                      },
                      tooltip: 'Delete',
                      icon: const Icon(Icons.delete, color: Colors.black))
                ]
              : [],
        ),
        floatingActionButton: ValueListenableBuilder<TextEditingValue>(
            valueListenable: _content,
            builder: (content, value, child) {
              if (value.text.isEmpty) {
                return Container();
              }

              return FloatingActionButton(
                onPressed: () {
                  if (isEditing) {
                    updateNote();
                  } else {
                    addNote();
                  }
                },
                child: const Icon(Icons.check),
              );
            }),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          children: [
            TextField(
              autofocus: !isEditing,
              autocorrect: true,
              controller: _content,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                  labelText: 'Note...'),
              style: const TextStyle(
                fontSize: 20.0,
              ),
              minLines: 10,
              maxLines: null,
            ),
            SwitchListTile(
                value: immediate,
                onChanged: (state) => {
                      setState(() {
                        immediate = state;
                      })
                    },
                secondary: const Icon(Icons.schedule),
                title: const Text('Show immediately')),
            buildButtonsRow(disable: immediate)
          ],
        ));
  }

  Widget buildButtonsRow({bool disable = false}) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: OutlinedButton(
              onPressed: disable
                  ? null
                  : () async {
                      final year = DateTime.now().year;

                      final result = await showDatePicker(
                          context: context,
                          initialDate: date,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(year + 100));

                      setState(() {
                        if (result != null) date = result;
                      });
                    },
              child: Text(DateFormat.yMMMMd(Platform.localeName)
                  .format(date)
                  .toString())),
        ),
      ),
      Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: OutlinedButton(
              onPressed: disable
                  ? null
                  : () async {
                      final result = await showTimePicker(
                        context: context,
                        initialTime: time,
                        builder: (context, child) {
                          return Theme(
                              data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.dark(
                                      primary: Colors.blue)),
                              child: child!);
                        },
                      );

                      setState(() {
                        if (result != null) time = result;
                      });
                    },
              child: Text(time.format(context))),
        ),
      )
    ]);
  }

  int computeTimestamp() {
    DateTime timestamp = DateTime(date.year, date.month, date.day, 0, 0, 0, 0);
    int remindAt = immediate
        ? 0
        : timestamp
            .add(Duration(hours: time.hour, minutes: time.minute))
            .millisecondsSinceEpoch;

    return remindAt;
  }
}
