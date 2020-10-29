import 'package:dbmonitor/api_models/longopsmodel.dart';
import 'package:dbmonitor/api_requests/longopsreq.dart';
import 'package:dbmonitor/pages/template.dart';
import 'package:dbmonitor/pages/longopsdetails.dart';
import 'package:dbmonitor/pages/topsqldetails.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Longops extends StatefulWidget {
  Longops({Key key}) : super(key: key);

  @override
  _LongopsState createState() => _LongopsState();
}

class _LongopsState extends State<Longops> {
  Future<Null> refreshPage() {
    return Future.delayed(Duration(seconds: 1), () => null);
  }

  final longopsReq = LongopsRequest();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TemplatePage(
        context,
        title: "Longops",
        body: RefreshIndicator(
          onRefresh: refreshPage,
          child: FutureBuilder(
              future: longopsReq.fetchLongops(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<LongopsModel> dados = snapshot.data;
                  return ListView(
                    children: [...dados.map((e) => buildLongops(e)).toList()],
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

  Widget buildLongops(LongopsModel sql) {
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
                        text: sql.sQLID,
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
                    "${sql.machine}",
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
                    "Início: ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    "${sql.inicio}",
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
                    "Fim Estimado: ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    "${sql.fimEstimado}",
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
                    "Mensagem: ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Container(
                    width: 280,
                    child: Text(
                      "${sql.mensagem}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Tempo Restante: ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    "${sql.tempoRestante}",
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
                          sql.text == null
                              ? false
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TopsqlDetailsPage(
                                          sql.text, sql.sQLID)))
                        },
                      ),
                    ],
                  ))
            ]),
      ),
    );
  }
}
