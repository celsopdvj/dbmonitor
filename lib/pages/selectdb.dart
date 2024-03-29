import 'package:dbmonitor/api_requests/notificationsreq.dart';
import 'package:dbmonitor/models/databasemodel.dart';
import 'package:dbmonitor/pages/databases.dart';
import 'package:dbmonitor/pages/template.dart';
import 'package:dbmonitor/redux/globalvariables.dart' as gv;
import 'package:dbmonitor/repositories/databaserepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SelectdbPage extends StatefulWidget {
  SelectdbPage({Key key}) : super(key: key);

  @override
  _SelectdbPageState createState() => _SelectdbPageState();
}

class _SelectdbPageState extends State<SelectdbPage> {
  DatabaseModel dropdownValue = gv.GlobalVariables.database;
  var dbRepo = DatabaseRepository();

  @override
  Widget build(BuildContext context) {
    return TemplatePage(
      title: "Banco de dados",
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Selecione a base de dados:",
              style: TextStyle(color: Colors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder(
                  stream: dbRepo.databases,
                  builder: (context, snapshot) {
                    print(FirebaseAuth.instance.currentUser.uid);
                    if (snapshot.hasError) {
                      print(snapshot.error.toString());
                      return Text("Error");
                    }
                    if (snapshot.hasData) {
                      return DropdownButton<DatabaseModel>(
                        hint: Text(
                          "Selecione",
                          style: TextStyle(color: Colors.white),
                        ),
                        value: dropdownValue,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        dropdownColor: Colors.grey[800],
                        style: TextStyle(color: Colors.white),
                        underline: Container(
                          height: 2,
                          color: Colors.white,
                        ),
                        onChanged: (DatabaseModel nv) {
                          setState(() {
                            dropdownValue = nv;

                            gv.GlobalVariables.database = nv;
                            gv.GlobalVariables.connectionString =
                                'Data Source=(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=${nv.host})(PORT=${nv.port})))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=${nv.serviceName})));User Id=${nv.user};Password=${nv.password};';

                            gv.GlobalVariables.storeState
                                .dispatch(gv.Actions.SwitchDatabase);
                          });
                        },
                        items: snapshot.data
                            .map<DropdownMenuItem<DatabaseModel>>(
                                (DatabaseModel value) {
                          return DropdownMenuItem<DatabaseModel>(
                            value: value,
                            child: Text(value.name),
                          );
                        }).toList(),
                      );
                    }
                    return DropdownButton<DatabaseModel>(
                      hint: Text(
                        "Carregando...",
                        style: TextStyle(color: Colors.white),
                      ),
                      value: dropdownValue,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      dropdownColor: Colors.grey[800],
                      style: TextStyle(color: Colors.white),
                      underline: Container(
                        height: 2,
                        color: Colors.white,
                      ),
                      onChanged: (DatabaseModel newValue) {
                        return false;
                      },
                      items: <DatabaseModel>[]
                          .map<DropdownMenuItem<DatabaseModel>>(
                              (DatabaseModel value) {
                        return DropdownMenuItem<DatabaseModel>(
                          value: value,
                          child: Text(value.name),
                        );
                      }).toList(),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DatabasesPage())),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
