import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stickynotifs/models/state.dart';
import 'package:stickynotifs/pages/details.dart';

class NoteList extends StatelessWidget {
  const NoteList({Key? key, required this.current}) : super(key: key);

  final bool current;

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteModel>(builder: ((context, model, child) {
      final list = current ? model.notes : model.pending;
      return ListView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(list[index].content),
              onDismissed: (direction) {
                model.remove(list[index].id!);
              },
              direction: DismissDirection.startToEnd,
              background: Container(color: Colors.red),
              child: ListTile(
                title: Text(list[index].content),
                onTap: () => {
                  Navigator.pushNamed(context, DetailsPage.routeName,
                      arguments: DetailsPageArguments(list[index].id!))
                },
              ),
            );
          });
    }));
  }
}
