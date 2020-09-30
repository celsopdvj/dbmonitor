import 'package:dbmonitor/models/databasemodel.dart';
import 'package:redux/redux.dart';

enum Actions { SwitchDatabase }

DatabaseModel databaseReducer(DatabaseModel newDb, dynamic action) {
  if (action == Actions.SwitchDatabase) {
    var newDatabase = DatabaseModel();
    newDatabase.host = "NOVO";
    newDatabase.name = "NOVO";
    newDatabase.port = 1521;
    newDatabase.user = "NOVO";
    newDatabase.serviceName = "NOVO";
    return newDatabase;
  }
  return null;
}

class GlobalVariables {
  static DatabaseModel database;

  static Store<DatabaseModel> storeState =
      new Store<DatabaseModel>(databaseReducer, initialState: null);
}
