import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:stickynotifs/models/database.dart';
import 'package:stickynotifs/models/note.dart';
import 'package:stickynotifs/util/notes.dart';
import 'package:stickynotifs/util/notifications.dart';

class NoteModel extends ChangeNotifier {
  /// Internal, private items
  List<Note> _items = [];

  /// An unmodifiable view of the items.
  UnmodifiableListView<Note> get items => UnmodifiableListView(_items);

  /// A unmodifiable view of reversed items with remindAt lesser than current time.
  UnmodifiableListView<Note> get notes => UnmodifiableListView(_items
      .where((element) =>
          (element.remindAt ?? 0) < DateTime.now().millisecondsSinceEpoch)
      .toList()
      .reversed);

  /// View of pending items
  UnmodifiableListView<Note> get pending =>
      UnmodifiableListView(_items.where((element) =>
          (element.remindAt ?? 0) > DateTime.now().millisecondsSinceEpoch));

  void add(String content, {int remindAt = 0}) async {
    final now = DateTime.now();
    final nowMS = now.millisecondsSinceEpoch;

    final note = Note(
        content: content,
        createdAt: nowMS,
        updatedAt: nowMS,
        remindAt: remindAt);

    final insertedId = await NoteHelper.insertNote(note);

    note.id = insertedId;
    _items.add(note);

    // Trigger a new notification

    handleNotification(note, now, remindAt);

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

  Note getNoteById(int id) {
    final note = _items.firstWhere((element) => element.id == id);

    return note;
  }

  void updateNote(int id, Note note) async {
    final index = _items.indexWhere((element) => element.id == id);
    if (index > -1) {
      _items[index] = note;

      await NoteHelper.updateNote(id, note);
      notifyListeners();

      // TODO notification stuff
      handleNotification(note, DateTime.now(), note.remindAt ?? 0);
    }
  }

  void remove(int id) async {
    final note = _items.firstWhere((element) => element.id == id);
    _items.remove(note);
    await NoteHelper.deleteNote(note.id!);

    notifyListeners();

    // Cancel the notification if present
    NotificationsService().cancel(note.id!);
  }

  void removeAll() {
    _items.clear();

    notifyListeners();
  }
}
