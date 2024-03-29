import 'dart:math';

import 'package:dbmonitor/api_models/advisormodel.dart';
import 'package:dbmonitor/api_requests/advisorreq.dart';
import 'package:dbmonitor/pages/template.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/src/text_element.dart' as tx;
import 'package:charts_flutter/src/text_style.dart' as ts;

import 'package:percent_indicator/circular_percent_indicator.dart';

class AdvisorPage extends StatefulWidget {
  AdvisorPage({Key key}) : super(key: key);

  @override
  _AdvisorPageState createState() => _AdvisorPageState();
}

class _AdvisorPageState extends State<AdvisorPage> {
  var _advisors = ['DbCache', 'Memory Target', 'PGA', 'Hit Ratio'];
  String _selectedAdvisor = 'DbCache';

  AdvisorRequest advRequest;
  AdvisorRequest advRequestHit;

  @override
  void initState() {
    super.initState();
    advRequest = AdvisorRequest();
    advRequestHit = AdvisorRequest();
  }

  static double _curValue = 0;
  static double _curFactor = 0;

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
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TemplatePage(
        title: "Advisor",
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Text(
                    "Advisor: ",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                DropdownButton<String>(
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    value: _selectedAdvisor,
                    dropdownColor: Colors.grey[800],
                    style: TextStyle(color: Colors.white),
                    underline: Container(
                      height: 2,
                      color: Colors.white,
                    ),
                    items: _advisors.map((String adv) {
                      return DropdownMenuItem<String>(
                        child: Text(
                          adv,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        value: adv,
                      );
                    }).toList(),
                    onChanged: (novoItem) {
                      setState(() {
                        _selectedAdvisor = novoItem;
                      });
                    }),
              ],
            ),
            _selectedAdvisor != 'Hit Ratio' ? buildVisualizacao() : SizedBox(),
            _selectedAdvisor == 'Hit Ratio' ? buildHitRatio() : SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget buildVisualizacao() {
    switch (_selectedAdvisor) {
      case 'DbCache':
        return buildDefault('DbCache');
        break;
      case 'Memory Target':
        return buildDefault('MemoryTarget');
        break;
      case 'PGA':
        return buildDefault('PGA');
        break;
      default:
        return null;
    }
  }

  Widget buildDefault(String endpoint) {
    return FutureBuilder(
      future: advRequest.fetchAdvisor(tipo: endpoint),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<AdvisorModel> dados = snapshot.data;
          return ListView(
            shrinkWrap: true,
            children: [
              Card(
                color: Colors.grey[800],
                child: buildGraph(dados),
              ),
            ],
          );
        }

        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white),
          ),
        );
      },
    );
  }

  Widget buildGraph(List<AdvisorModel> adv) {
    return adv.length == 0
        ? Container(
            height: 80,
            width: 380,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Advisor não configurado para a instância',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        : Row(
            children: [
              RotatedBox(
                child: Text(
                  "Tempo Estimado",
                  style: TextStyle(color: Colors.white),
                ),
                quarterTurns: 3,
              ),
              Container(
                width: 360,
                height: MediaQuery.of(context).size.height * .75,
                padding: EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _selectedAdvisor,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * .6,
                        child: charts.LineChart(
                          buildSeries(_selectedAdvisor, cores[0], adv),
                          animate: true,
                          selectionModels: [
                            charts.SelectionModelConfig(
                                changedListener: (charts.SelectionModel model) {
                              if (model.hasDatumSelection) {
                                _curFactor = model.selectedSeries[0]
                                    .domainFn(model.selectedDatum[0].index);
                                _curValue = model.selectedSeries[0]
                                    .measureFn(model.selectedDatum[0].index);
                              }
                            })
                          ],
                          behaviors: [
                            charts.LinePointHighlighter(
                              symbolRenderer: CustomCircleSymbolRenderer(),
                            )
                          ],
                          customSeriesRenderers: [
                            charts.LineRendererConfig(
                                includeArea: true,
                                customRendererId: 'customArea',
                                includePoints: true,
                                areaOpacity: 0.3)
                          ],
                        ),
                      ),
                      Center(
                        child: Text(
                          'Tamanho (GB)',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ]),
              ),
            ],
          );
  }

  Widget buildHitRatio() {
    return FutureBuilder(
      future: advRequestHit.fetchAdvisor(tipo: 'HitRatio'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<AdvisorModel> dados = snapshot.data;
          return Container(
            margin: EdgeInsets.only(top: 15),
            color: Colors.grey[800],
            padding: EdgeInsets.symmetric(vertical: 20),
            height: MediaQuery.of(context).size.height * .5,
            width: MediaQuery.of(context).size.width * .95,
            child: Column(
              children: [
                CircularPercentIndicator(
                  radius: 250,
                  percent: dados.first.hitRatio == null
                      ? 0
                      : (dados.first.hitRatio / 100),
                  center: Text(
                    "${dados.first.hitRatio == null ? 0 : dados.first.hitRatio.toStringAsFixed(2)}%",
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
                    "Hit Ratio",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white),
          ),
        );
      },
    );
  }

  List<charts.Series<LinearSerie, num>> buildSeries(
      String id, dynamic cor, List<AdvisorModel> data) {
    return [
      charts.Series<LinearSerie, num>(
        id: id,
        domainFn: (LinearSerie serie, _) => serie.nome,
        measureFn: (LinearSerie serie, _) => serie.medida,
        data: compileData(data),
        colorFn: (_, __) => cor,
      )..setAttribute(charts.rendererIdKey, 'customArea')
    ];
  }

  List<LinearSerie> compileData(List<AdvisorModel> data) {
    return data
        .map((AdvisorModel e) => LinearSerie(e.tamanhoGB, e.fator))
        .toList();
  }
}

class LinearSerie {
  final double nome;
  final double medida;

  LinearSerie(this.nome, this.medida);
}

class GraphId {
  final String name;
  final String id;
  bool selected;

  GraphId(this.name, this.id, {this.selected = true});
}

class CustomCircleSymbolRenderer extends charts.CircleSymbolRenderer {
  @override
  void paint(charts.ChartCanvas canvas, Rectangle<num> bounds,
      {List<int> dashPattern,
      charts.Color fillColor,
      charts.FillPatternType fillPattern,
      charts.Color strokeColor,
      double strokeWidthPx}) {
    super.paint(canvas, bounds,
        dashPattern: dashPattern,
        fillColor: fillColor,
        strokeColor: strokeColor,
        strokeWidthPx: strokeWidthPx);

    var textStyle = ts.TextStyle();
    textStyle.color = charts.Color.white;
    textStyle.fontSize = 15;

    canvas.drawText(
        tx.TextElement(
          '${_AdvisorPageState._curFactor.toStringAsFixed(2)} GB / Fator ${_AdvisorPageState._curValue}',
          style: textStyle,
        ),
        (bounds.left).round(),
        (bounds.top - 28).round());
  }
}
