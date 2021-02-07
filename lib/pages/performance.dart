import 'dart:async';
import 'package:dbmonitor/api_models/performancemodel.dart';
import 'package:dbmonitor/api_requests/performancereq.dart';
import 'package:dbmonitor/dialogs/customdialog.dart';
import 'package:dbmonitor/pages/template.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PerformancePage extends StatefulWidget {
  PerformancePage({Key key}) : super(key: key);

  @override
  _PerformancePageState createState() => _PerformancePageState(false);
}

class _PerformancePageState extends State<PerformancePage> {
  final bool animate;
  Future<List<PerformanceModel>> _dadosGrafico;

  Timer _timer;
  int _tempoTimer = 60;
  int _timerAtual;

  Future<void> updateData() async {
    _dadosGrafico = request.fetchPerformance();
    resetTimer();
  }

  void resetTimer() {
    setState(() {
      _timerAtual = _tempoTimer;
      startTimer();
    });
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    if (_timer != null) {
      _timer.cancel();
      _timerAtual = _tempoTimer;
    }
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_timerAtual < 1) {
            timer.cancel();
            _dadosGrafico = request.fetchPerformance();
            resetTimer();
          } else {
            _timerAtual = _timerAtual - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }

  _PerformancePageState(this.animate);

  var cores = [
    charts.MaterialPalette.green.shadeDefault,
    charts.MaterialPalette.blue.shadeDefault,
    charts.MaterialPalette.red.shadeDefault,
    charts.MaterialPalette.deepOrange.shadeDefault,
    charts.MaterialPalette.cyan.shadeDefault,
    charts.MaterialPalette.pink.shadeDefault,
    charts.MaterialPalette.purple.shadeDefault,
    charts.MaterialPalette.teal.shadeDefault,
    charts.MaterialPalette.lime.shadeDefault,
    charts.MaterialPalette.indigo.shadeDefault,
    charts.MaterialPalette.yellow.shadeDefault,
    charts.MaterialPalette.cyan.shadeDefault,
    charts.MaterialPalette.red.shadeDefault,
    charts.MaterialPalette.lime.shadeDefault,
  ];

  final List<GraphId> graficos = [
    GraphId("CPU", "cpu"),
    GraphId("CPU Wait", "bcpu"),
    GraphId("Scheduler", "scheduler"),
    GraphId("User I/O", "uio"),
    GraphId("System I/O", "sio"),
    GraphId("Concurrency", "concurrency"),
    GraphId("Application", "application"),
    GraphId("Commit", "commit"),
    GraphId("Configuration", "configuration"),
    GraphId("Administrative", "administrative"),
    GraphId("Network", "network"),
    GraphId("Queueing", "queueing"),
    GraphId("Cluster", "clust"),
    GraphId("Other", "other"),
  ];

  final request = PerformanceRequest();
  final _scrollController = ScrollController();
  bool _selectAll;

  @override
  void initState() {
    _timerAtual = _tempoTimer;
    _dadosGrafico = request.fetchPerformance();
    _selectAll = true;
    startTimer();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TemplatePage(
      title: "Desempenho",
      body: RefreshIndicator(
        onRefresh: updateData,
        child: Container(
          child: Column(
            children: [
              buildFilter(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView(
                    shrinkWrap: true,
                    controller: _scrollController,
                    children: [
                      ...graficos
                          .where((e) => e.selected)
                          .toList()
                          .asMap()
                          .map((i, GraphId e) =>
                              MapEntry(i, buildGraph(e.name, e.id, cores[i])))
                          .values
                          .toList(),
                      Container(
                        child: Text(
                          'Próxima atualização em $_timerAtual segudos',
                          style: TextStyle(color: Colors.white),
                        ),
                        margin: EdgeInsets.all(5),
                        alignment: Alignment.centerRight,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFilter() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: ExpandableNotifier(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                ScrollOnExpand(
                  scrollOnExpand: false,
                  scrollOnCollapse: false,
                  child: Container(
                    color: Colors.grey[800],
                    child: ExpandablePanel(
                      theme: const ExpandableThemeData(
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                        tapBodyToCollapse: true,
                        iconColor: Colors.white,
                      ),
                      header: Container(
                        child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              "Filtros",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.2,
                                  fontSize: 18),
                            )),
                      ),
                      expanded: Container(
                        height: MediaQuery.of(context).size.height * .70,
                        child: ListView(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectAll = !_selectAll;
                                  graficos.forEach((element) {
                                    element.selected = _selectAll;
                                  });
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 15),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Selecionar todos",
                                      style: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                    Theme(
                                      data: Theme.of(context).copyWith(
                                        unselectedWidgetColor: Colors.white,
                                      ),
                                      child: Checkbox(
                                        activeColor: Colors.white,
                                        checkColor: Colors.black,
                                        value: _selectAll,
                                        onChanged: (bool value) {
                                          setState(() {
                                            _selectAll = value;
                                            graficos.forEach((element) {
                                              element.selected = _selectAll;
                                            });
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.white,
                            ),
                            ...graficos
                                .asMap()
                                .map((i, GraphId e) => MapEntry(
                                      i,
                                      buildCheckBox(e, i),
                                    ))
                                .values
                                .toList(),
                          ],
                        ),
                      ),
                      builder: (_, collapsed, expanded) {
                        return Padding(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          child: Expandable(
                            collapsed: collapsed,
                            expanded: expanded,
                            theme: const ExpandableThemeData(crossFadePoint: 0),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCheckBox(GraphId e, int i) {
    return GestureDetector(
      onTap: () {
        setState(() {
          graficos[i].selected = !graficos[i].selected;
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              e.name,
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1,
              ),
            ),
            Theme(
              data: Theme.of(context).copyWith(
                unselectedWidgetColor: Colors.white,
              ),
              child: Checkbox(
                activeColor: Colors.white,
                checkColor: Colors.black,
                value: e.selected,
                onChanged: (bool value) {
                  setState(() {
                    graficos[i].selected = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGraph(String title, String id, dynamic cor) {
    return FutureBuilder(
      future: _dadosGrafico,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        if (snapshot.hasData) {
          List<PerformanceModel> data = snapshot.data;
          return Card(
            color: Colors.grey[800],
            child: Container(
              height: 300,
              padding: EdgeInsets.all(10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * .33,
                      child: charts.TimeSeriesChart(
                        [
                          buildSeries(id, cor, data),
                        ],
                        animate: animate,
                        selectionModels: [
                          charts.SelectionModelConfig(
                              changedListener: (charts.SelectionModel model) {
                            if (model.hasDatumSelection)
                              print(model.selectedSeries[0]
                                  .measureFn(model.selectedDatum[0].index));
                          })
                        ],
                        dateTimeFactory: const charts.LocalDateTimeFactory(),
                        primaryMeasureAxis: charts.NumericAxisSpec(
                          renderSpec: new charts.GridlineRendererSpec(
                            labelStyle: new charts.TextStyleSpec(
                              fontSize: 12,
                              color: charts.MaterialPalette.white,
                            ),
                            lineStyle: new charts.LineStyleSpec(
                              color: charts.MaterialPalette.white,
                            ),
                          ),
                        ),
                        domainAxis: new charts.DateTimeAxisSpec(
                          renderSpec: new charts.SmallTickRendererSpec(
                            labelStyle: new charts.TextStyleSpec(
                              fontSize: 12,
                              color: charts.MaterialPalette.white,
                            ),
                            lineStyle: new charts.LineStyleSpec(
                              color: charts.MaterialPalette.white,
                            ),
                          ),
                        ),
                        customSeriesRenderers: [
                          charts.LineRendererConfig(
                              includeArea: true,
                              customRendererId: 'customArea',
                              includePoints: true,
                              areaOpacity: 0.3)
                        ],
                      ),
                    ),
                  ]),
            ),
          );
        }
        return Container(
          height: 270,
          padding: EdgeInsets.symmetric(vertical: 100, horizontal: 160),
          color: Colors.grey[800],
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white),
          ),
        );
      },
    );
  }

  List<LinearSerie> compileData(String id, List<PerformanceModel> data) {
    return data
        .map((e) => LinearSerie(DateTime.parse(e.sampletime), e.getProp(id)))
        .toList();
  }

  charts.Series<LinearSerie, DateTime> buildSeries(
      String id, dynamic cor, List<PerformanceModel> data) {
    return charts.Series<LinearSerie, DateTime>(
      id: id,
      domainFn: (LinearSerie serie, _) => serie.hora,
      measureFn: (LinearSerie serie, _) => serie.medida,
      data: compileData(id, data),
      colorFn: (_, __) => cor,
    )..setAttribute(charts.rendererIdKey, 'customArea');
  }
}

class LinearSerie {
  final DateTime hora;
  final double medida;

  LinearSerie(this.hora, this.medida);
}

class GraphId {
  final String name;
  final String id;
  bool selected;

  GraphId(this.name, this.id, {this.selected = true});
}
