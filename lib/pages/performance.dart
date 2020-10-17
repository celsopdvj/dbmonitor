import 'dart:async';
import 'package:dbmonitor/api_models/performancemodel.dart';
import 'package:dbmonitor/api_requests/performancereq.dart';
import 'package:dbmonitor/pages/template.dart';
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
  int _tempoTimer = 10;
  int _timerAtual;

  @override
  void initState() {
    _timerAtual = _tempoTimer;
    _dadosGrafico = request.fetchPerformance();
    startTimer();
    super.initState();
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

  static var corCpu = charts.MaterialPalette.green.shadeDefault;
  // static var corRam = charts.MaterialPalette.red.shadeDefault;
  // static var corHd = charts.MaterialPalette.blue.shadeDefault;
  // static var corWait = charts.MaterialPalette.yellow.shadeDefault;
  // static var corIo = charts.MaterialPalette.purple.shadeDefault;
  var request = PerformanceRequest();

  @override
  Widget build(BuildContext context) {
    return TemplatePage(
        title: "Desempenho",
        body: Container(
          // onRefresh: updateData,
          child: ListView(
            children: [
              FutureBuilder(
                future: _dadosGrafico,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return buildGraph("CPU", snapshot.data);
                  }
                  return Text("carregando");
                },
              ),
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
        ));
  }

  Widget buildGraph(String title, List<PerformanceModel> data) {
    return Card(
      color: Colors.grey[800],
      child: Container(
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
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Container(
                height: MediaQuery.of(context).size.height * .33,
                child: charts.TimeSeriesChart(
                  [buildSeries("cpu", corCpu, data)],
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

  List<LinearSerie> compileData(String id, List<PerformanceModel> data) {
    switch (id) {
      case "cpu":
        return data
            .map((e) => LinearSerie(DateTime.parse(e.sampletime), e.cpu))
            .toList();
        break;
      default:
    }

    return null;
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
