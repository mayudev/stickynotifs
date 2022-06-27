import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stickynotifs/models/note_model.dart';
import 'package:stickynotifs/widgets/heading.dart';

class NoteInput extends StatefulWidget {
  const NoteInput({Key? key}) : super(key: key);

  @override
  State<NoteInput> createState() => _NoteInputState();
}

class _NoteInputState extends State<NoteInput> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Heading(text: 'Quick note'),
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Type here...',
          ),
          keyboardType: TextInputType.multiline,
          maxLines: null,
        ),
        _buildButtons(context)
      ],
    );
  }

  void handleNoteAdded(NoteModel cart) {
    cart.add(controller.text);

    controller.clear();
    FocusScope.of(context).unfocus();
  }

  Widget _buildButtons(BuildContext context) {
    const double margin = 8.0;
    var cart = Provider.of<NoteModel>(context, listen: false);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
            margin: const EdgeInsets.all(margin),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(120, 40),
                ),
                onPressed: () => handleNoteAdded(cart),
                child: const Text('Add now')))
      ],
    );
  }
}
