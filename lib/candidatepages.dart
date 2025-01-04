import 'package:flutter/material.dart';
// import 'main.dart';
// import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class CandidateDetails extends StatefulWidget {
  final int candidateId;

  CandidateDetails({super.key, required this.candidateId});

  @override
  _CandidateDetailsState createState() => _CandidateDetailsState();
}

class _CandidateDetailsState extends State<CandidateDetails> {
  List<Map<String, dynamic>> details = [];
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    _loadPeople();
  }

  void _loadPeople() async {
    final data =
        await DatabaseHelper.instance.fetchCandidateDetails(widget.candidateId);
    setState(() {
      details = data;
    });
  }

  void _addDetail(String key, String value) async {
    await DatabaseHelper.instance
        .addCandidateDetails(widget.candidateId, key, value);
    _loadPeople();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${widget.candidateId}'),
      ),
      body: ListView.builder(
        itemCount: details.length,
        itemBuilder: (context, index) {
          final detail = details[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(detail['key']!),
              subtitle: Text(detail['value']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              final keyController = TextEditingController();
              final valueController = TextEditingController();

              return AlertDialog(
                title: const Text('Add Detail'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                        controller: keyController,
                        decoration: const InputDecoration(labelText: 'Name')),
                    TextField(
                        controller: valueController,
                        decoration: const InputDecoration(labelText: 'Role')),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel')),
                  ElevatedButton(
                    onPressed: () {
                      _addDetail(keyController.text, valueController.text);
                      Navigator.pop(context);
                    },
                    child: const Text('Save'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

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

  Future<List<Map<String, dynamic>>> fetchCandidateDetails(
      int candidateId) async {
    final db = await database;
    return await db.query('candidate_datails',
        where: 'candidate_Id = ?', whereArgs: [candidateId]);
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
