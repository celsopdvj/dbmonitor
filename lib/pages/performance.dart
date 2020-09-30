import 'dart:async';
import 'dart:math';

import 'package:dbmonitor/pages/template.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PerformancePage extends StatefulWidget {
  PerformancePage({Key key}) : super(key: key);

  @override
  _PerformancePageState createState() => _PerformancePageState(false);
}

class _PerformancePageState extends State<PerformancePage> {
  static charts.Series seriesCpu;
  static charts.Series seriesRam;
  static charts.Series seriesHd;
  static charts.Series seriesWait;
  static charts.Series seriesIo;

  final bool animate;

  bool first = true;

  // factory _PerformancePageState.withSampleData() {
  //   return new _PerformancePageState(
  //     _createSampleData(),
  //     animate: true,
  //   );
  // }

  @override
  void initState() {
    super.initState();
    if (first) {
      updateData();
    }
    first = false;
  }

  Future<Null> updateData() {
    setState(() {
      _createSampleData();
      resetTimer();
    });
    return Future.delayed(Duration(seconds: 1), () => null);
  }

  Timer _timer;
  int _start = 10;

  void resetTimer() {
    setState(() {
      _start = 10;
    });
    startTimer();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            updateData();
            resetTimer();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  _PerformancePageState(this.animate);

  static var corCpu = charts.MaterialPalette.green.shadeDefault;
  static var corRam = charts.MaterialPalette.red.shadeDefault;
  static var corHd = charts.MaterialPalette.blue.shadeDefault;
  static var corWait = charts.MaterialPalette.yellow.shadeDefault;
  static var corIo = charts.MaterialPalette.purple.shadeDefault;

  @override
  Widget build(BuildContext context) {
    return TemplatePage(
        title: "Desempenho",
        body: RefreshIndicator(
          onRefresh: updateData,
          child: ListView(
            children: [
              buildGraph("Uso de CPU", seriesCpu),
              buildGraph("Uso de RAM", seriesRam),
              buildGraph("Uso de HD", seriesHd),
              buildGraph("User Wait", seriesWait),
              buildGraph("User IO", seriesIo),
              Container(
                child: Text(
                  'Próxima atualização em $_start segudos',
                  style: TextStyle(color: Colors.white),
                ),
                margin: EdgeInsets.all(5),
                alignment: Alignment.centerRight,
              ),
            ],
          ),
        ));
  }

  Widget buildGraph(String title, charts.Series serie) {
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
                  [serie],
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

  static List<LinearSales> _getRandomData() {
    var rng = Random();

    return [
      LinearSales(DateTime(2020, 9, 1, 10, 0), rng.nextInt(100)),
      LinearSales(DateTime(2020, 9, 1, 10, 10), rng.nextInt(100)),
      LinearSales(DateTime(2020, 9, 1, 10, 20), rng.nextInt(100)),
      LinearSales(DateTime(2020, 9, 1, 10, 30), rng.nextInt(100)),
      LinearSales(DateTime(2020, 9, 1, 10, 40), rng.nextInt(100)),
      LinearSales(DateTime(2020, 9, 1, 10, 50), rng.nextInt(100)),
      LinearSales(DateTime(2020, 9, 1, 11, 0), rng.nextInt(100)),
    ];
  }

  static charts.Series<LinearSales, DateTime> sampleData(
      String id, dynamic cor) {
    return charts.Series<LinearSales, DateTime>(
      id: id,
      domainFn: (LinearSales sales, _) => sales.hora,
      measureFn: (LinearSales sales, _) => sales.medida,
      data: _getRandomData(),
      colorFn: (_, __) => cor,
    )..setAttribute(charts.rendererIdKey, 'customArea');
  }

  static void _createSampleData() {
    seriesCpu = sampleData("CPU", corCpu);
    seriesRam = sampleData("RAM", corRam);
    seriesHd = sampleData("HD", corHd);
    seriesWait = sampleData("Wait", corWait);
    seriesIo = sampleData("IO", corIo);
  }

  List<Widget> buildGraphLegend(String title, dynamic cor) {
    return [
      Container(
        margin: EdgeInsetsDirectional.only(end: 5, start: 5),
        color: Color.fromARGB(cor.a, cor.r, cor.g, cor.b),
        child: SizedBox(
          height: 15,
          width: 15,
        ),
      ),
      Text(title)
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final DateTime hora;
  final int medida;

  LinearSales(this.hora, this.medida);
}
