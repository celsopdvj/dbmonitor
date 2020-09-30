import 'package:dbmonitor/pages/template.dart';
import 'package:dbmonitor/pages/longopsdetails.dart';
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TemplatePage(
        title: "Long Operations",
        body: RefreshIndicator(
          onRefresh: refreshPage,
          child: ListView(
            children: [
              buildNotification(),
              buildNotification(),
              buildNotification(),
              buildNotification(),
              buildNotification(),
              buildNotification(),
              buildNotification(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNotification() {
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
                        text: "cn7k9ndh900sp",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.lightBlue),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                "Máquina: DESKTOP-U86FH",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              Text(
                "Usuário: CELSO",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              Text(
                "Tempo decorrido: 1h:32m",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              Text(
                "Tempo restante: 2h:44m",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              LinearPercentIndicator(
                percent: .56,
                leading: Text(
                  "Progresso",
                  style: TextStyle(color: Colors.white),
                ),
                progressColor: Colors.blue,
              ),
              ButtonBarTheme(
                  data: ButtonBarThemeData(),
                  child: ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: const Text('DETALHES'),
                        onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LongopsdetailsPage()))
                        },
                      ),
                    ],
                  ))
            ]),
      ),
    );
  }
}
