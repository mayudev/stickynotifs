import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class DetailsPageArguments {
  final int id;

  DetailsPageArguments(this.id);
}

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);

  static const routeName = '/details';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as DetailsPageArguments;

    return Scaffold(
        appBar: AppBar(title: const Text('StickyNotifs')),
        body: Center(
          child: Text('hey ${args.id}'),
        ));
  }
}
