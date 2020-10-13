import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dbmonitor/models/databasemodel.dart';

class DatabaseRepository {
  CollectionReference _collection = Firestore.instance.collection('database');

  void add(DatabaseModel database) {
    _collection.add(database.toMap());
  }

  void update(String documentId, DatabaseModel database) =>
      _collection.document(documentId).updateData(database.toMap());

  void delete(String documentId) => _collection.document(documentId).delete();

  Stream<List<DatabaseModel>> get databases =>
      _collection.snapshots().map((query) => query.documents
          .map<DatabaseModel>((document) => DatabaseModel.fromMap(document))
          .toList());
}
