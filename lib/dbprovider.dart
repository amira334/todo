import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/todo.dart';
import 'dart:async';

class TodosDatabase {
  static final TodosDatabase instance = TodosDatabase._init();
  static Database? _database;

  TodosDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('todos.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const todoTextType = 'TEXT NOT NULL';
    const isDoneType = 'BOOLEAN NOT NULL';
    const noteType = 'TEXT NOT NULL';
    const dateType = 'TEXT NOT NULL';
    const startTimeType = 'TEXT NOT NULL';
    const endTimeType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE $tableTodos (
        ${ToDoFields.id} $idType,
        ${ToDoFields.todoText} $todoTextType,
        ${ToDoFields.isDone} $isDoneType CHECK  (${ToDoFields.isDone} IN (0, 1))
        ${ToDoFields.note} $noteType,
        ${ToDoFields.date} $dateType,
        ${ToDoFields.startTime} $startTimeType,
        ${ToDoFields.endTime} $endTimeType
      )''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<ToDo> create(ToDo todo) async {
    final db = await instance.database;
    final id = await db.insert(tableTodos, todo.toJson());
    return todo.copy(id: id);
  }

  Future<ToDo> readToDo(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableTodos,
      columns: ToDoFields.values,
      where: '${ToDoFields.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return ToDo.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<ToDo>> readAllTodos() async {
    final db = await instance.database;
    final result = await db.query(tableTodos);
    return result.map((json) => ToDo.fromJson(json)).toList();
  }

  Future<int> update(ToDo todo) async {
    final db = await instance.database;
    return db.update(
      tableTodos,
      todo.toJson(),
      where: '${ToDoFields.id} = ?',
      whereArgs: [todo.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableTodos,
      where: '${ToDoFields.id} = ?',
      whereArgs: [id],
    );
  }
}
