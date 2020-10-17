import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dbmonitor/models/databasemodel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseRepository {
  CollectionReference _collection =
      FirebaseFirestore.instance.collection('database');

  void add(DatabaseModel database) {
    _collection.add(database.toMap());
  }

  void update(String documentId, DatabaseModel database) =>
      _collection.doc(documentId).update(database.toMap());

  void delete(String documentId) => _collection.doc(documentId).delete();

  Stream<List<DatabaseModel>> get databases =>
      _collection.snapshots().map((query) => query.docs
          .map<DatabaseModel>((document) => DatabaseModel.fromMap(document))
          .where((db) => db.uiduser == FirebaseAuth.instance.currentUser.uid)
          .toList());
}
