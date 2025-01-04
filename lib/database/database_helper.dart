// import 'package:flutter/material.dart';
// import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';



class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = '$dbPath/candidates.db';

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE candidates(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL
        )''');
        await db.execute('''
        CREATE TABLE candidate_details (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          candidate_id INTEGER NOT NULL,
          key TEXT NOT NULL,
          value TEXT NOT NULL,
          FOREIGN KEY (candidate_id) REFENCES candidates (id)
        )
      ''');

        await db.execute(''' CREATE TABLE people (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    candidateId INTEGER NOT NULL,
    name TEXT NOT NULL,
    role TEXT,
    contact TEXT,
    FOREIGN KEY (candidateId) REFERENCES candidates (id)
    ) ''');
      },
    );
  }

  Future<int> addCandidate(String name) async {
    final db = await database;
    return await db.insert('candidates', {'name': name});
  }

  Future<List<Map<String, dynamic>>> fetchCandidates() async {
    final db = await database;
    return await db.query('candidates');
  }

  Future<int> addCandidateDetails(
      int candidateId, String key, String value) async {
    final db = await database;
    return await db.insert('candidate_details', {
      'candidate_id': candidateId,
      'key': key,
      'value': value,
    });
  }

   Future<List<Map<String, dynamic>>> fetchCandidateDetails(int candidateId) async {
    final db = await database;
    return await db.query(
      'candidate_details',
      where: 'candidate_id = ?', 
      whereArgs: [candidateId]
    );
  }

  Future<int> deleteCandidate(int id) async {
    final db = await instance.database;
    await db.delete('people', where: 'candidateId = ?', whereArgs: [id]);
    return await db.delete('cnadidates', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deletePerson(int id) async {
    final db = await instance.database;
    return await db.delete('people', where: 'id = ?', whereArgs: [id]);
  }
}
