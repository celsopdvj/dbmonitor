import 'package:dbmonitor/api_models/topsqlmodel.dart';
import 'package:dbmonitor/api_requests/topsqlreq.dart';
import 'package:dbmonitor/pages/template.dart';
import 'package:dbmonitor/pages/topsqldetails.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Topsql extends StatefulWidget {
  Topsql({Key key}) : super(key: key);

  @override
  _TopsqlState createState() => _TopsqlState();
}

class _TopsqlState extends State<Topsql> {
  Future<Null> refreshPage() {
    return Future.delayed(Duration(seconds: 1), () => null);
  }

  final topsqlReq = TopsqlRequest();
  bool _selectAll = true;
  List<Categoria> categorias;
  int execucoes;
  int dias;
  TextEditingController _controllerExec = TextEditingController();
  TextEditingController _controllerDias = TextEditingController();
  Future<List<TopsqlModel>> _futureData;

  @override
  void initState() {
    super.initState();
    _controllerExec.text = "20";
    _controllerDias.text = "2";
    execucoes = 20;
    dias = 2;
    _futureData = topsqlReq.fetchTopsql(dias: dias, execucoes: execucoes);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TemplatePage(
        title: "Top SQL",
        body: RefreshIndicator(
          onRefresh: refreshPage,
          child: FutureBuilder(
              future: _futureData,
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState != ConnectionState.waiting) {
                  List<TopsqlModel> dados = snapshot.data;
                  dados = dados.map((e) {
                    if (e.modulo == null) e.modulo = "Não informado";
                    return e;
                  }).toList();
                  if (categorias == null)
                    categorias = dados
                        .map((e) => e.modulo)
                        .toSet()
                        .map((e) => Categoria(e, true))
                        .toList();
                  return ListView(
                    children: [
                      buildFilter(),
                      ...dados.map((e) => builTopsql(e)).toList(),
                    ],
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

  Widget builTopsql(TopsqlModel sql) {
    if (!categorias.any((c) => c.tipo == sql.modulo && c.selected)) {
      return Container();
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Card(
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
                          text: sql.sqlId,
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
                      "${sql.modulo}",
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
                      "Execuções: ",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      "${sql.execuEs.toInt()}",
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
                      "Tempo por Execução: ",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      "${sql.tempoExec.toStringAsFixed(2)}s",
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
                      "Tempo Total: ",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      "${sql.tempoTot.toStringAsFixed(2)}s",
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
                      "Tuplas por Execução: ",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      "${sql.linhaExec.toStringAsFixed(2)}",
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
                      "Tuplas total: ",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      "${sql.linhasTot.toInt()}",
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TopsqlDetailsPage(
                                        sql.sqlText, sql.sqlId)))
                          },
                        ),
                      ],
                    ))
              ]),
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
                      expanded: categorias == null
                          ? Container()
                          : Container(
                              height: MediaQuery.of(context).size.height * .65,
                              child: ListView(
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Text(
                                        "Quantidade mínima de execuções: ",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                      Container(
                                        height: 50,
                                        width: 90,
                                        child: TextFormField(
                                          controller: _controllerExec,
                                          keyboardType: TextInputType.number,
                                          style: TextStyle(color: Colors.amber),
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          textAlign: TextAlign.end,
                                          decoration: InputDecoration(
                                            hintText: "Qtd.",
                                            hintStyle:
                                                TextStyle(color: Colors.white),
                                            fillColor: Colors.white,
                                            enabledBorder: InputBorder.none,
                                            // enabledBorder: UnderlineInputBorder(
                                            //   borderSide: BorderSide(
                                            //       color: Colors.white),
                                            // ),
                                            border: InputBorder.none,
                                            // border: UnderlineInputBorder(
                                            //   borderSide: BorderSide(
                                            //       color: Colors.white),
                                            // ),
                                            labelStyle:
                                                TextStyle(color: Colors.white),
                                            focusedBorder: InputBorder.none,
                                            // focusedBorder: UnderlineInputBorder(
                                            //   borderSide: const BorderSide(
                                            //     color: Colors.white,
                                            //   ),
                                            // ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 250,
                                        child: Text(
                                          "Dias: ",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        width: 90,
                                        child: TextFormField(
                                          controller: _controllerDias,
                                          keyboardType: TextInputType.number,
                                          style: TextStyle(color: Colors.amber),
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          textAlign: TextAlign.end,
                                          decoration: InputDecoration(
                                            hintText: "Qtd.",
                                            hintStyle:
                                                TextStyle(color: Colors.white),
                                            fillColor: Colors.white,
                                            enabledBorder: InputBorder.none,
                                            // enabledBorder: UnderlineInputBorder(
                                            //   borderSide: BorderSide(
                                            //       color: Colors.white),
                                            // ),
                                            border: InputBorder.none,
                                            // border: UnderlineInputBorder(
                                            //   borderSide: BorderSide(
                                            //       color: Colors.white),
                                            // ),
                                            labelStyle:
                                                TextStyle(color: Colors.white),
                                            focusedBorder: InputBorder.none,
                                            // focusedBorder: UnderlineInputBorder(
                                            //   borderSide: const BorderSide(
                                            //     color: Colors.white,
                                            //   ),
                                            // ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  FlatButton(
                                    color: Colors.amber,
                                    onPressed: () {
                                      setState(() {
                                        _futureData = null;
                                        execucoes = _controllerExec.text.isEmpty
                                            ? 0
                                            : int.parse(_controllerExec.text);
                                        dias = _controllerDias.text.isEmpty
                                            ? 0
                                            : int.parse(_controllerDias.text);
                                        _futureData = topsqlReq.fetchTopsql(
                                            dias: dias, execucoes: execucoes);
                                      });
                                    },
                                    child: Text(
                                      "Filtrar",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.amber,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectAll = !_selectAll;
                                        categorias.forEach((element) {
                                          element.selected = _selectAll;
                                        });
                                      });
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 15),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                              unselectedWidgetColor:
                                                  Colors.white,
                                            ),
                                            child: Checkbox(
                                              activeColor: Colors.white,
                                              checkColor: Colors.black,
                                              value: _selectAll,
                                              onChanged: (bool value) {
                                                setState(() {
                                                  _selectAll = value;
                                                  categorias.forEach((element) {
                                                    element.selected =
                                                        _selectAll;
                                                  });
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  ...categorias
                                      .asMap()
                                      .map((i, Categoria e) => MapEntry(
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

  Widget buildCheckBox(Categoria e, int i) {
    return GestureDetector(
      onTap: () {
        setState(() {
          categorias[i].selected = !categorias[i].selected;
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              e.tipo == null ? "Não informado" : e.tipo,
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
                    categorias[i].selected = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Categoria {
  String tipo;
  bool selected;

  Categoria(this.tipo, this.selected);
}
