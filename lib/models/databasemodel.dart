import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dbmonitor/models/basemodel.dart';

class DatabaseModel extends BaseModel {
  String name;
  String host;
  int port;
  String serviceName;
  String user;
  String password;

  String _documentId;

  DatabaseModel();

  DatabaseModel.fromMap(DocumentSnapshot document) {
    _documentId = document.documentID;

    this.name = document.data["name"];
    this.host = document.data["host"];
    this.port = document.data["port"];
    this.serviceName = document.data["serviceName"];
    this.user = document.data["user"];
    this.password = document.data["password"];
  }

  @override
  toMap() {
    var map = new Map<String, dynamic>();
    map['name'] = this.name;
    map['host'] = this.host;
    map['port'] = this.port;
    map['serviceName'] = this.serviceName;
    map['user'] = this.user;
    map['password'] = this.password;
    return map;
  }

  @override
  String documentId() => _documentId;
}