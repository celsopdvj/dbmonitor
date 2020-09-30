import 'package:dbmonitor/pages/databases.dart';
import 'package:dbmonitor/pages/template.dart';
import 'package:dbmonitor/redux/globalvariables.dart';
import 'package:flutter/material.dart';
import 'package:dbmonitor/redux/globalvariables.dart' as gv;

import 'models/databasemodel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DbMonitor',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'DbMonitor'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dropdownValue = 'PROD';

  @override
  void initState() {
    var newDatabase = DatabaseModel();
    newDatabase.host = "NOVO2";
    newDatabase.name = dropdownValue;
    newDatabase.port = 1521;
    newDatabase.user = "NOVO2";
    newDatabase.serviceName = "NOVO2";

    GlobalVariables.database = newDatabase;
    GlobalVariables.storeState.dispatch(gv.Actions.SwitchDatabase);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TemplatePage(
        title: "DbMonitor",
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
                DropdownButton<String>(
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
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                      var newDatabase = DatabaseModel();
                      newDatabase.host = "NOVO2";
                      newDatabase.name = newValue;
                      newDatabase.port = 1521;
                      newDatabase.user = "NOVO2";
                      newDatabase.serviceName = "NOVO2";

                      GlobalVariables.database = newDatabase;
                      GlobalVariables.storeState
                          .dispatch(gv.Actions.SwitchDatabase);
                    });
                  },
                  items: <String>['PROD', 'HOMOLOG', 'DESENV', 'TEST']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
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
        )));
  }
}
