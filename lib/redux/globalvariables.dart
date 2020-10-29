import 'package:dbmonitor/models/databasemodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

enum Actions { SwitchDatabase }

DatabaseModel databaseReducer(DatabaseModel newDb, dynamic action) {
  return null;
}

String userReducer(String newUuid, dynamic action) {
  return null;
}

class GlobalVariables {
  static DatabaseModel database;
  static String connectionString;
  static BuildContext context;

  static get userName => FirebaseAuth.instance.currentUser != null &&
          FirebaseAuth.instance.currentUser.displayName != null &&
          FirebaseAuth.instance.currentUser.displayName != ""
      ? FirebaseAuth.instance.currentUser.displayName
      : "Não logado";

  static get email => FirebaseAuth.instance.currentUser != null &&
          FirebaseAuth.instance.currentUser.email != null &&
          FirebaseAuth.instance.currentUser.email != ""
      ? FirebaseAuth.instance.currentUser.email
      : "Não logado";

  static Store<DatabaseModel> storeState =
      new Store<DatabaseModel>(databaseReducer, initialState: null);
}
