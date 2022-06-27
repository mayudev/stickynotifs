import 'dart:collection';

import 'package:flutter/foundation.dart';

class NoteModel extends ChangeNotifier {
  /// Internal, private items
  final List<String> _items = [];

  /// An unmodifiable view of the items.
  UnmodifiableListView<String> get items => UnmodifiableListView(_items);

  /// A reversed unmodifiable view of items.
  UnmodifiableListView<String> get notes =>
      UnmodifiableListView(_items.reversed);

  void add(String note) {
    _items.add(note);

    notifyListeners();
  }

  void remove(String note) {
    _items.remove(note);

    notifyListeners();
  }

  void removeAll() {
    _items.clear();

    notifyListeners();
  }
}
