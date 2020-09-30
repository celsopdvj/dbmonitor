import 'package:dbmonitor/pages/template.dart';
import 'package:dbmonitor/pages/topsqldetails.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Topsql extends StatefulWidget {
  Topsql({Key key}) : super(key: key);

  @override
  _TopsqlState createState() => _TopsqlState();
}

class _TopsqlState extends State<Topsql> {
  Future<Null> refreshPage() {
    return Future.delayed(Duration(seconds: 1), () => null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TemplatePage(
        title: "Top SQL",
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
                "Módulo: APPLICATION1",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              Text(
                "Execuções: 22",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              Text(
                "Tempo por Execução: 23s",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              Text(
                "Tempo Total: 7m:42s",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              Text(
                "Tuplas por Execução: 2",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              Text(
                "Tuplas total: 44",
                style: TextStyle(fontSize: 14, color: Colors.white),
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
                                  builder: (context) => TopsqlDetailsPage()))
                        },
                      ),
                    ],
                  ))
            ]),
      ),
    );
  }
}
