import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

//
part 'todolist.g.dart';

class Todolist extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get content => text()();
}

@DriftDatabase(tables: [Todolist])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Stream<List<TodolistData>> watchEntries() {
    return (select(todolist)).watch();
  }

  Future<List<TodolistData>> get allTodoEntries => select(todolist).get();

  Future<int> addTodo(String content) {
    return into(todolist).insert(TodolistCompanion(content: Value(content)));
  }

  Future<int> updateTodo(TodolistData todo, String content) {
    return (update(todolist)..where((tbl) => tbl.id.equals(todo.id)))
        .write(TodolistCompanion(
      content: Value(content),
    ));
  }

  Future<void> deleteTodo(TodolistData todolistData){
    return (delete(todolist)..where((tbl) => tbl.id.equals(todolistData.id))).go();
  }
}
  LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'db.sqlite'));
      return NativeDatabase(file);
    });
  }



