import 'package:dbmonitor/api_models/topsqlmodel.dart';
import 'package:dbmonitor/api_requests/topsqlreq.dart';
import 'package:dbmonitor/pages/template.dart';
import 'package:dbmonitor/pages/topsqldetails.dart';
import 'package:flutter/material.dart';

class Topsql extends StatefulWidget {
  Topsql({Key key}) : super(key: key);

  @override
  _TopsqlState createState() => _TopsqlState();
}

class _TopsqlState extends State<Topsql> {
  Future<Null> refreshPage() {
    return Future.delayed(Duration(seconds: 1), () => null);
  }

  final topsqlReq = TopsqlRequest();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TemplatePage(
        context,
        title: "Top SQL",
        body: RefreshIndicator(
          onRefresh: refreshPage,
          child: FutureBuilder(
              future: topsqlReq.fetchTopsql(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<TopsqlModel> dados = snapshot.data;
                  return ListView(
                    children: [...dados.map((e) => builTopsql(e)).toList()],
                  );
                }
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                );
              }),
        ),
      ),
    );
  }

  Widget builTopsql(TopsqlModel sql) {
    return Card(
      color: Colors.grey[800],
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "SQL ID: ",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      TextSpan(
                        text: sql.sqlId,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    "Módulo: ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    "${sql.modulo}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Execuções: ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    "${sql.execuEs.toInt()}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Tempo por Execução: ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    "${sql.tempoExec.toStringAsFixed(2)}s",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Tempo Total: ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    "${sql.tempoTot.toStringAsFixed(2)}s",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Tuplas por Execução: ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    "${sql.linhaExec.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Tuplas total: ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    "${sql.linhasTot.toInt()}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              ButtonBarTheme(
                  data: ButtonBarThemeData(),
                  child: ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: const Text(
                          'DETALHES',
                          style: TextStyle(
                            color: Colors.amber,
                          ),
                        ),
                        onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TopsqlDetailsPage(
                                      sql.sqlText, sql.sqlId)))
                        },
                      ),
                    ],
                  ))
            ]),
      ),
    );
  }
}
