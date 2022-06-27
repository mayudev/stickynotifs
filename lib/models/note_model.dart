import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:stickynotifs/models/database.dart';
import 'package:stickynotifs/models/note.dart';

class NoteModel extends ChangeNotifier {
  /// Internal, private items
  List<Note> _items = [];

  /// An unmodifiable view of the items.
  UnmodifiableListView<Note> get items => UnmodifiableListView(_items);

  /// A reversed unmodifiable view of items.
  UnmodifiableListView<Note> get notes => UnmodifiableListView(_items);

  void add(String content, {int remindAt = 0}) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final note = Note(
        content: content, createdAt: now, updatedAt: now, remindAt: remindAt);

    final insertedId = await NoteHelper.insertNote(note);

    note.id = insertedId;
    _items.add(note);

    notifyListeners();
  }

  NoteModel() {
    fetch();
  }

  Future<void> fetch() async {
    final notes = await NoteHelper.getNotes();

    _items = notes.toList();
    notifyListeners();
  }

  void remove(int id) async {
    final note = _items.firstWhere((element) => element.id == id);
    _items.remove(note);
    await NoteHelper.deleteNote(note.id!);

    notifyListeners();
  }

  void removeAll() {
    _items.clear();

    notifyListeners();
  }
}
