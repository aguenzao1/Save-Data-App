import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:crypto/crypto.dart';
import 'dart:convert';

part 'database.g.dart';

class Candidates extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get password => text()(); // Add password column
}

class CandidateDetails extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get candidateId => integer().references(Candidates, #id)();
  TextColumn get key => text()();
  TextColumn get value => text()();
}

@DriftDatabase(tables: [Candidates, CandidateDetails])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from < 2) {
            await m.addColumn(candidates, candidates.password);
          }
        },
      );

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  Future<bool> verifyPassword(int candidateId, String password) async {
    final candidate = await (select(candidates)..where((t) => t.id.equals(candidateId))).getSingleOrNull();
    if (candidate == null) return false;
    return candidate.password == _hashPassword(password);
  }

  Future<int> addCandidate(String name, String password) async {
    final hashedPassword = _hashPassword(password);
    return into(candidates).insert(CandidatesCompanion(
      name: Value(name),
      password: Value(hashedPassword),
    ));
  }

  Future<bool> updateCandidate(int id, String name, String password) async {
    if (await verifyPassword(id, password)) {
      await (update(candidates)..where((t) => t.id.equals(id)))
          .write(CandidatesCompanion(name: Value(name)));
      return true;
    }
    return false;
  }

  Future<bool> updateCandidateDetail(
    int candidateId,
    int detailId,
    String key,
    String value,
    String password,
  ) async {
    if (await verifyPassword(candidateId, password)) {
      await (update(candidateDetails)..where((t) => t.id.equals(detailId)))
          .write(CandidateDetailsCompanion(
            key: Value(key),
            value: Value(value),
          ));
      return true;
    }
    return false;
  }

  Future<bool> deleteCandidateDetail(
    int candidateId,
    int detailId,
    String password,
  ) async {
    if (await verifyPassword(candidateId, password)) {
      await (delete(candidateDetails)..where((t) => t.id.equals(detailId))).go();
      return true;
    }
    return false;
  }

  Future<List<Candidate>> fetchCandidates() => select(candidates).get();

  Future<bool> deleteCandidate(int id, String password) async {
    if (await verifyPassword(id, password)) {
      await (delete(candidateDetails)..where((t) => t.candidateId.equals(id))).go();
      await (delete(candidates)..where((t) => t.id.equals(id))).go();
      return true;
    }
    return false;
  }

  Future<int> addCandidateDetails(int candidateId, String key, String value) {
    return into(candidateDetails).insert(CandidateDetailsCompanion(
      candidateId: Value(candidateId),
      key: Value(key),
      value: Value(value),
    ));
  }

  Future<List<CandidateDetail>> fetchCandidateDetails(int candidateId) {
    return (select(candidateDetails)
          ..where((t) => t.candidateId.equals(candidateId)))
        .get();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'caidats.db'));
    return NativeDatabase.createInBackground(file);
  });
}