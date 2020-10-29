import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UserScopedModel extends Model {
  User _user = FirebaseAuth.instance.currentUser;
  FirebaseAuth _auth = FirebaseAuth.instance;

  static UserScopedModel of(BuildContext context) =>
      ScopedModel.of<UserScopedModel>(context);

  // UserScopedModel() {
  //   _auth.authStateChanges().listen((event) {
  //     _user = event;
  //     notifyListeners();
  //   });
  // }

  void login(email, password) async {
    var authRes = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    _user = authRes.user;
    notifyListeners();
  }

  void logOut() async {
    await _auth.signOut();
    _user = null;
    notifyListeners();
  }

  User get user => _user;

  String get userName => _user == null ? "Não logado" : _user.displayName;
  String get email => _user == null ? "Não logado" : _user.email;
}
