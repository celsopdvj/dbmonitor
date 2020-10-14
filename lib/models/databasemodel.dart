import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dbmonitor/models/basemodel.dart';

class DatabaseModel extends BaseModel {
  String name;
  String host;
  int port;
  String serviceName;
  String user;
  String password;
  String uiduser;

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
    this.uiduser = document.data["uiduser"];
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is DatabaseModel && other.name == name;
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
    map['uiduser'] = this.uiduser;
    return map;
  }

  @override
  String documentId() => _documentId;

  @override
  int get hashCode => super.hashCode;
}
