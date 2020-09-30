import 'package:dbmonitor/pages/template.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class TablespacePage extends StatefulWidget {
  TablespacePage({Key key}) : super(key: key);

  @override
  _TablespacePageState createState() => _TablespacePageState();
}

class _TablespacePageState extends State<TablespacePage> {
  var format = NumberFormat("#,##0.00");

  Future<Null> refreshPage() {
    return Future.delayed(Duration(seconds: 1), () => null);
  }

  @override
  Widget build(BuildContext context) {
    return TemplatePage(
      body: RefreshIndicator(
        onRefresh: refreshPage,
        child: ListView(
          children: [
            buildTablespace("TBSP0001", 1110.0, 1047.0, 0.75),
            buildTablespace("TBSP0002", 60, 50.2, 0.30),
            buildTablespace("TBSP0003", 175200, 169481.3, 0.75),
            buildTablespace("TBSP0004", 1605419.3, 1322860, 0.60),
          ],
        ),
      ),
      title: "Tablespaces",
    );
  }

  Widget buildTablespace(
      String tbl, double alocado, double utilizado, double usadoMax) {
    return Card(
      color: Colors.grey[800],
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: tbl,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  WidgetSpan(
                    child: tbl != "TBSP0004"
                        ? Icon(
                            Icons.check,
                            color: Colors.green,
                          )
                        : Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                  )
                ]),
              ),
              Text(
                "Tamanho alocado: ${format.format(alocado)} MB",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              Text(
                "Tamanho utilizado: ${format.format(utilizado)} MB",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              Text(
                "Expansão automática: Sim",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              LinearPercentIndicator(
                percent: (utilizado / alocado),
                leading: Text(
                  "Espaço Alocado Utilizado",
                  style: TextStyle(color: Colors.white),
                ),
                progressColor: Colors.blue,
              ),
              LinearPercentIndicator(
                percent: usadoMax,
                leading: Text(
                  "Espaço Utilizado do Máx.",
                  style: TextStyle(color: Colors.white),
                ),
                progressColor: Colors.blue,
              ),
            ]),
      ),
    );
  }
}
