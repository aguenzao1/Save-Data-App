import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

class Candidates extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
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
  int get schemaVersion => 1;

  Future<int> updateCandidate(int id, String name) {
    return (update(candidates)..where((t) => t.id.equals(id)))
      .write(CandidatesCompanion(name: Value(name)));
  }

  Future<int> updateCandidateDetail(int id, String key, String value) {
    return (update(candidateDetails)..where((t) => t.id.equals(id)))
      .write(CandidateDetailsCompanion(
        key: Value(key),
        value: Value(value),
      ));
  }

  Future<int> deleteCandidateDetail(int id) {
    return (delete(candidateDetails)..where((t) => t.id.equals(id))).go();
  }

  // Keep existing methods...
  Future<int> addCandidate(String name) {
    return into(candidates).insert(CandidatesCompanion.insert(name: name));
  }

  Future<List<Candidate>> fetchCandidates() {
    return select(candidates).get();
  }

  Future<int> deleteCandidate(int id) async {
    await (delete(candidateDetails)..where((t) => t.candidateId.equals(id))).go();
    return await (delete(candidates)..where((t) => t.id.equals(id))).go();
  }

  Future<int> addCandidateDetails(int candidateId, String key, String value) {
    return into(candidateDetails).insert(
      CandidateDetailsCompanion.insert(
        candidateId: candidateId,
        key: key,
        value: value,
      ),
    );
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