import 'package:dbmonitor/models/databasemodel.dart';
import 'package:dbmonitor/pages/databases.dart';
import 'package:dbmonitor/pages/template.dart';
import 'package:dbmonitor/redux/globalvariables.dart' as gv;
import 'package:flutter/material.dart';

class SelectdbPage extends StatefulWidget {
  SelectdbPage({Key key}) : super(key: key);

  @override
  _SelectdbPageState createState() => _SelectdbPageState();
}

class _SelectdbPageState extends State<SelectdbPage> {
  String dropdownValue = 'PROD';

  @override
  void initState() {
    var newDatabase = DatabaseModel();
    newDatabase.host = "NOVO2";
    newDatabase.name = dropdownValue;
    newDatabase.port = 1521;
    newDatabase.user = "NOVO2";
    newDatabase.serviceName = "NOVO2";

    gv.GlobalVariables.database = newDatabase;
    gv.GlobalVariables.storeState.dispatch(gv.Actions.SwitchDatabase);
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

                      gv.GlobalVariables.database = newDatabase;
                      gv.GlobalVariables.storeState
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
