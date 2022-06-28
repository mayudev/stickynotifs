import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stickynotifs/models/state.dart';

class DetailsPageArguments {
  final int id;

  DetailsPageArguments(this.id);
}

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);

  static const routeName = '/details';

  DetailsPageArguments args(BuildContext context) {
    return ModalRoute.of(context)!.settings.arguments as DetailsPageArguments;
  }

  void delete(BuildContext context) {
    final notes = Provider.of<NoteModel>(context, listen: false);

    notes.remove(args(context).id);
    pop(context);
  }

  void pop(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as DetailsPageArguments;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Note'),
          actions: [
            IconButton(
                onPressed: () {
                  delete(context);
                },
                icon: const Icon(Icons.delete, color: Colors.black))
          ],
        ),
        body: Center(
          child: Text('hey ${args.id}'),
        ));
  }
}
