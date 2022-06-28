import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stickynotifs/models/state.dart';
import 'package:stickynotifs/pages/create.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key, required this.current}) : super(key: key);

  final bool current;

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  @override
  Widget build(BuildContext context) {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });

    return Consumer<NoteModel>(builder: ((context, model, child) {
      final list = widget.current ? model.notes : model.pending;
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
                  Navigator.pushNamed(context, CreatePage.routeName,
                      arguments: CreatePageArguments(list[index].id))
                },
              ),
            );
          });
    }));
  }
}
