import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stickynotifs/models/note_model.dart';

class NoteList extends StatelessWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteModel>(
        builder: ((context, model, child) => ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: model.notes.length,
            reverse: true,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(model.notes[index].content),
                onTap: () => model.remove(model.notes[index].id!),
              );
            })));
  }
}
