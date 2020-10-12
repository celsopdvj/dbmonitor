import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dbmonitor/models/usermodel.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class UserRepository {
  CollectionReference _collection = Firestore.instance.collection('user');

  void add(UserModel user) {
    var bytes = utf8.encode(user.senha);
    user.senha = sha256.convert(bytes).toString();
    _collection.add(user.toMap());
  }

  void update(String documentId, UserModel user) =>
      _collection.document(documentId).updateData(user.toMap());

  void delete(String documentId) => _collection.document(documentId).delete();

  Stream<List<UserModel>> get users =>
      _collection.snapshots().map((query) => query.documents
          .map<UserModel>((document) => UserModel.fromMap(document))
          .toList());
}
