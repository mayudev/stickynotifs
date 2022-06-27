import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Heading extends StatelessWidget {
  const Heading({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, left: 4.0),
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14.0,
            color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
