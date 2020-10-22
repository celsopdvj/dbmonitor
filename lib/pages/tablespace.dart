import 'package:dbmonitor/api_models/tablespacemodel.dart';
import 'package:dbmonitor/api_requests/tablespacesreq.dart';
import 'package:dbmonitor/pages/template.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class TablespacePage extends StatefulWidget {
  TablespacePage({Key key}) : super(key: key);

  @override
  _TablespacePageState createState() => _TablespacePageState();
}

class _TablespacePageState extends State<TablespacePage> {
  var format = NumberFormat("#,##0.00");

  final tbsRequest = TablespaceRequest();

  Future<Null> refreshPage() {
    return Future.delayed(Duration(seconds: 1), () => null);
  }

  @override
  Widget build(BuildContext context) {
    return TemplatePage(
      body: RefreshIndicator(
        onRefresh: refreshPage,
        child: FutureBuilder(
            future: tbsRequest.fetchTablespace(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<TablespaceModel> tbs = snapshot.data;
                return ListView(
                    children: tbs
                        .map((e) => buildTablespace(
                            e.tablespacename,
                            e.sizemb,
                            e.sizemb - e.freemb,
                            ((e.maxsizemb - e.maxfreemb) / e.maxsizemb) * 100,
                            e.status))
                        .toList());
              }
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              );
            }),
      ),
      title: "Tablespaces",
    );
  }

  Widget buildTablespace(String tbl, double alocado, double utilizado,
      double usadoMax, String status) {
    return Card(
      color: Colors.grey[800],
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: tbl,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                          color: Colors.amber,
                        )),
                    WidgetSpan(
                      child: status == "ONLINE"
                          ? Icon(
                              Icons.check,
                              color: Colors.amber,
                            )
                          : Icon(
                              Icons.close,
                              color: Colors.amber,
                            ),
                    )
                  ]),
                ),
              ),
              Text(
                "Tamanho alocado: ${format.format(alocado)} MB",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  letterSpacing: .8,
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                "Tamanho utilizado: ${format.format(utilizado)} MB",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  letterSpacing: .8,
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CircularPercentIndicator(
                          radius: 100,
                          percent: (utilizado / alocado),
                          center: Text(
                            "${((utilizado / alocado) * 100).toStringAsFixed(2)}%",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          progressColor: Colors.amber,
                          backgroundColor: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Espaço Alocado Utilizado",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 120,
                    child: VerticalDivider(
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CircularPercentIndicator(
                          radius: 100,
                          percent: usadoMax / 100,
                          center: Text(
                            "${(usadoMax).toStringAsFixed(2)}%",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          progressColor: Colors.amber,
                          backgroundColor: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Espaço Utilizado do Máx.",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
