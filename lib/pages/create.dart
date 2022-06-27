import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stickynotifs/models/state.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  static const routeName = '/create';

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final _content = TextEditingController();

  bool immediate = false;
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  @override
  void dispose() {
    _content.dispose();
    super.dispose();
  }

  void addNote() {
    final value = _content.text;

    var notes = Provider.of<NoteModel>(context, listen: false);

    DateTime timestamp = DateTime(date.year, date.month, date.day, 0, 0, 0, 0);
    int remindAt = immediate
        ? 0
        : timestamp
            .add(Duration(hours: time.hour, minutes: time.minute))
            .millisecondsSinceEpoch;

    notes.add(value, remindAt: remindAt);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create new note'),
        ),
        floatingActionButton: ValueListenableBuilder<TextEditingValue>(
            valueListenable: _content,
            builder: (content, value, child) {
              if (value.text.isEmpty) {
                return Container();
              }

              return FloatingActionButton(
                onPressed: () {
                  addNote();
                },
                child: const Icon(Icons.check),
              );
            }),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          children: [
            TextField(
              autofocus: true,
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
                          lastDate: DateTime(DateTime.now().year + 100));

                      setState(() {
                        if (result != null) date = result;
                      });
                    },
              child: Text(DateFormat.yMMMMd().format(date).toString())),
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
}
