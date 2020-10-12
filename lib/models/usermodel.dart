import 'package:dbmonitor/models/basemodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel extends BaseModel {
  String nome;
  String email;
  String senha;

  String _documentId;

  UserModel();

  UserModel.parametrizado(this.nome,this.email,this.senha);

  UserModel.fromMap(DocumentSnapshot document) {
    _documentId = document.documentID;

    this.nome = document.data["nome"];
    this.email = document.data["email"];
    this.senha = document.data["senha"];
  }

  @override
  toMap() {
    var map = new Map<String, dynamic>();
    map['nome'] = this.nome;
    map['email'] = this.email;
    map['senha'] = this.senha;
    return map;
  }

  @override
  String documentId() => _documentId;
}
