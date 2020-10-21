import 'package:dbmonitor/api_models/advisormodel.dart';
import 'package:dbmonitor/api_requests/advisorreq.dart';
import 'package:dbmonitor/custom_charts/gauge.dart';
import 'package:dbmonitor/pages/template.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class AdvisorPage extends StatefulWidget {
  AdvisorPage({Key key}) : super(key: key);

  @override
  _AdvisorPageState createState() => _AdvisorPageState();
}

class _AdvisorPageState extends State<AdvisorPage> {
  var _advisors = ['DbCache', 'Memory Target', 'PGA', 'Hit Ratio'];
  String _selectedAdvisor = 'DbCache';

  var advRequest = AdvisorRequest();

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
            buildVisualizacao()
          ],
        ),
      ),
    );
  }

  Widget buildVisualizacao() {
    switch (_selectedAdvisor) {
      case 'DbCache':
      case 'Memory Target':
      case 'PGA':
        return buildDefault();
        break;
      case 'Hit Ratio':
        return buildHitRatio();
        break;
      default:
        return null;
    }
  }

  Widget buildDefault() {
    return FutureBuilder(
      future: advRequest.fetchAdvisor(tipo: _selectedAdvisor),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<AdvisorModel> dados = snapshot.data;
          return ListView(
            shrinkWrap: true,
            children: [
              buildGraph(dados),
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
    return Card(
      color: Colors.grey[800],
      child: Container(
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
              Container(
                height: MediaQuery.of(context).size.height * .65,
                child: charts.BarChart(
                  [
                    buildSeries("id", cores[0], adv),
                  ],
                  animate: true,
                  selectionModels: [
                    charts.SelectionModelConfig(
                        changedListener: (charts.SelectionModel model) {
                      if (model.hasDatumSelection)
                        print(model.selectedSeries[0]
                            .measureFn(model.selectedDatum[0].index));
                    })
                  ],
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
                  domainAxis: new charts.AxisSpec(
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

  Widget buildHitRatio() {
    return Column(
      children: [
        Container(
            height: MediaQuery.of(context).size.height * .6,
            child: GaugeChart.withSampleData()),
        Text(
          "Hit Ratio: 97%",
          style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 20),
        )
      ],
    );
  }

  charts.Series<LinearSerie, String> buildSeries(
      String id, dynamic cor, List<AdvisorModel> data) {
    return charts.Series<LinearSerie, String>(
      id: id,
      domainFn: (LinearSerie serie, _) => serie.nome,
      measureFn: (LinearSerie serie, _) => serie.medida,
      data: compileData(id, data),
      colorFn: (_, __) => cor,
    )..setAttribute(charts.rendererIdKey, 'customArea');
  }

  List<LinearSerie> compileData(String id, List<AdvisorModel> data) {
    return data
        .map((e) => LinearSerie(e.tamanhoGB.toString(), e.fator))
        .toList();
  }
}

class LinearSerie {
  final String nome;
  final double medida;

  LinearSerie(this.nome, this.medida);
}

class GraphId {
  final String name;
  final String id;
  bool selected;

  GraphId(this.name, this.id, {this.selected = true});
}
