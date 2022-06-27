import 'package:sqflite/sqlite_api.dart';
import 'package:stickynotifs/models/database.dart';

class Note {
  int? id;
  final String content;
  final int createdAt;
  final int updatedAt;
  final int? remindAt;

  Note({
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.remindAt,
    this.id,
  });

  /// Convert a Note into a Map.
  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'remindAt': remindAt,
    };
  }

  factory Note.fromMap(Map<String, dynamic> raw) => Note(
      id: raw['id'],
      content: raw['content'],
      createdAt: raw['createdAt'],
      updatedAt: raw['updatedAt'],
      remindAt: raw['remindAt']);

  @override
  String toString() {
    return 'Note(id: $id, content: $content, created: $createdAt, updated: $updatedAt, remind: $remindAt)';
  }
}
