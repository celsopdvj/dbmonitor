import 'package:dbmonitor/custom_charts/gauge.dart';
import 'package:dbmonitor/pages/template.dart';
import 'package:flutter/material.dart';

class AdvisorPage extends StatefulWidget {
  AdvisorPage({Key key}) : super(key: key);

  @override
  _AdvisorPageState createState() => _AdvisorPageState();
}

class _AdvisorPageState extends State<AdvisorPage> {
  var _advisors = ['DbCache', 'Memory Target', 'PGA', 'Hit Ratio'];
  String _selectedAdvisor = 'DbCache';

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
            ...buildVisualizacao()
          ],
        ),
      ),
    );
  }

  List<Widget> buildVisualizacao() {
    switch (_selectedAdvisor) {
      case 'DbCache':
        return buildDbCache();
        break;
      case 'Memory Target':
        return buildMemTarget();
        break;
      case 'PGA':
        return buildPGA();
        break;
      case 'Hit Ratio':
        return buildHitRatio();
        break;
      default:
        return null;
    }
  }

  List<Widget> buildDbCache() {
    return <Widget>[
      SizedBox(
        height: 10,
      ),
      Container(
        padding: EdgeInsets.all(8),
        color: Colors.grey[800],
        child: Table(
          children: [
            TableRow(children: [
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "Tamanho",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "Fator",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "I/O",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "Buffer",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ]),
            TableRow(children: [
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "7",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "69.26",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "5G",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "883k",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ]),
            TableRow(children: [
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "14",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "24",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "19G",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "890k",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ]),
            TableRow(children: [
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "7",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "69.26",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "5G",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "883k",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ]),
            TableRow(children: [
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "7",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "69.26",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "5G",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "883k",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ]),
          ],
        ),
      )
    ];
  }

  List<Widget> buildMemTarget() {
    return <Widget>[
      SizedBox(
        height: 10,
      ),
      Container(
        padding: EdgeInsets.all(8),
        color: Colors.grey[800],
        child: Table(
          children: [
            TableRow(children: [
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "Tamanho",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "Fator",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "I/O",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "Buffer",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ]),
            TableRow(children: [
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "8",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "69.26",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "5G",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "883k",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ]),
            TableRow(children: [
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "14",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "24",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "19G",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "890k",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ]),
            TableRow(children: [
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "21",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "69.26",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "5G",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "883k",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ]),
            TableRow(children: [
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "7",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "69.26",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "5G",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "883k",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ]),
          ],
        ),
      )
    ];
  }

  List<Widget> buildPGA() {
    return <Widget>[
      SizedBox(
        height: 10,
      ),
      Container(
        padding: EdgeInsets.all(8),
        color: Colors.grey[800],
        child: Table(
          children: [
            TableRow(children: [
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "Tamanho",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "Fator",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "I/O",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "Buffer",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ]),
            TableRow(children: [
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "14",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "69.26",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "5G",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "883k",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ]),
            TableRow(children: [
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "14",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "34",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "19G",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "890k",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ]),
            TableRow(children: [
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "21",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "69.26",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "5G",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "883k",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ]),
            TableRow(children: [
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "7",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "69.26",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "5G",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Text(
                  "883k",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ]),
          ],
        ),
      )
    ];
  }

  List<Widget> buildHitRatio() {
    return <Widget>[
      Container(
          height: MediaQuery.of(context).size.height * .6,
          child: GaugeChart.withSampleData()),
      Text(
        "Hit Ratio: 97%",
        style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 20),
      )
    ];
  }
}
