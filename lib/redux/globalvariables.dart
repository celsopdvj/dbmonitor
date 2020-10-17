import 'package:dbmonitor/models/databasemodel.dart';
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

  static Store<DatabaseModel> storeState =
      new Store<DatabaseModel>(databaseReducer, initialState: null);
}
