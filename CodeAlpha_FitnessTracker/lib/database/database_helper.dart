import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/workout_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDB('fitness.db');

    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(
      Database db,
      int version,
      ) async {
    await db.execute('''
      CREATE TABLE workouts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        duration INTEGER NOT NULL,
        calories INTEGER NOT NULL
      )
    ''');
  }

  Future<int> insertWorkout(Workout workout) async {
    final db = await instance.database;

    return await db.insert(
      'workouts',
      workout.toMap(),
    );
  }

  Future<List<Workout>> getWorkouts() async {
    final db = await instance.database;

    final result = await db.query(
      'workouts',
      orderBy: 'id DESC',
    );

    return result.map((map) {
      return Workout.fromMap(map);
    }).toList();
  }

  Future<int> updateWorkout(Workout workout) async {
    final db = await instance.database;

    return await db.update(
      'workouts',
      workout.toMap(),
      where: 'id = ?',
      whereArgs: [workout.id],
    );
  }

  Future<int> deleteWorkout(int id) async {
    final db = await instance.database;

    return await db.delete(
      'workouts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}