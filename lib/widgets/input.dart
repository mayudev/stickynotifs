import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stickynotifs/models/state.dart';
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

  void handleNoteAdded(NoteModel notes) {
    final value = controller.text;

    if (value.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 1),
          content:
              Text("Enter content!", style: TextStyle(color: Colors.white))));
    } else {
      notes.add(value);
      controller.clear();
      FocusScope.of(context).unfocus();
    }
  }

  Widget _buildButtons(BuildContext context) {
    const double margin = 8.0;
    var notes = Provider.of<NoteModel>(context, listen: false);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
            margin: const EdgeInsets.all(margin),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(120, 40),
                ),
                onPressed: () => handleNoteAdded(notes),
                child: const Text('Add now')))
      ],
    );
  }
}
