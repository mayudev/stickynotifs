import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stickynotifs/models/state.dart';
import 'package:stickynotifs/pages/details.dart';

class NoteList extends StatelessWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteModel>(
        builder: ((context, model, child) => ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: model.notes.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(model.notes[index].content),
                onTap: () => {
                  Navigator.pushNamed(context, DetailsPage.routeName,
                      arguments: DetailsPageArguments(model.notes[index].id!))
                },
              );
            })));
  }
}
