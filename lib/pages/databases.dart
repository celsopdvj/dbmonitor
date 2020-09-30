import 'package:dbmonitor/pages/template.dart';
import 'package:flutter/material.dart';

class DatabasesPage extends StatefulWidget {
  DatabasesPage({Key key}) : super(key: key);

  @override
  _DatabasesPageState createState() => _DatabasesPageState();
}

class _DatabasesPageState extends State<DatabasesPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TemplatePage(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    fillColor: Colors.white,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                      color: Colors.white,
                    )),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Informe o nome';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: (MediaQuery.of(context).size.width - 42) / 2,
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Host',
                          fillColor: Colors.white,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          labelStyle: TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                            color: Colors.white,
                          )),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Informe o host';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width - 42) / 2,
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Porta',
                          fillColor: Colors.white,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          labelStyle: TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                            color: Colors.white,
                          )),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Informe a porta';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'SID',
                    fillColor: Colors.white,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                      color: Colors.white,
                    )),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Informe o SID';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Usuário',
                    fillColor: Colors.white,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                      color: Colors.white,
                    )),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Informe o usuário';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    fillColor: Colors.white,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                      color: Colors.white,
                    )),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Informe a senha';
                    }
                    return null;
                  },
                ),
              ),
              Builder(
                builder: (ctx) => RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Scaffold.of(ctx).showSnackBar(
                          SnackBar(content: Text('Processando dados')));
                    }
                  },
                  child: Text('Cadastrar'),
                ),
              ),
            ]),
          ),
        ),
        title: "Cadastro de bases",
        leading: false,
      ),
    );
  }
}
