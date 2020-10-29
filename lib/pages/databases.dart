import 'package:dbmonitor/dialogs/customdialog.dart';
import 'package:dbmonitor/models/databasemodel.dart';
import 'package:dbmonitor/pages/template.dart';
import 'package:dbmonitor/repositories/databaserepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DatabasesPage extends StatefulWidget {
  DatabasesPage({Key key}) : super(key: key);

  @override
  _DatabasesPageState createState() => _DatabasesPageState();
}

class _DatabasesPageState extends State<DatabasesPage> {
  final _formKey = GlobalKey<FormState>();

  var cntNome = TextEditingController();
  var cntHost = TextEditingController();
  var cntPort = TextEditingController();
  var cntSid = TextEditingController();
  var cntUser = TextEditingController();
  var cntSenha = TextEditingController();

  var dbRespo = DatabaseRepository();

  @override
  Widget build(BuildContext context) {
    return TemplatePage(
      context,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              buildTextField(
                label: "Nome",
                icon: Icons.text_fields,
                controller: cntNome,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Informe o nome';
                  }
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.zero,
                      width: (MediaQuery.of(context).size.width - 12) / 2,
                      child: TextFormField(
                        controller: cntHost,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.cloud,
                            color: Colors.white,
                          ),
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
                      width: (MediaQuery.of(context).size.width - 72) / 2,
                      child: TextFormField(
                        controller: cntPort,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.filter_1,
                            color: Colors.white,
                          ),
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
              buildTextField(
                label: "SID",
                icon: Icons.vpn_key,
                controller: cntSid,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Informe o SID';
                  }
                  return null;
                },
              ),
              buildTextField(
                label: "Usuário",
                icon: Icons.person,
                controller: cntUser,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Informe o usuário';
                  }
                  return null;
                },
              ),
              buildTextField(
                label: "Senha",
                icon: Icons.lock,
                controller: cntSenha,
                obscure: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Informe a senha';
                  }
                  return null;
                },
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      var db = DatabaseModel();
                      db.host = cntHost.text;
                      db.name = cntNome.text;
                      db.serviceName = cntSid.text;
                      db.user = cntUser.text;
                      db.password = cntSenha.text;
                      db.port = int.parse(cntPort.text);
                      db.uiduser = FirebaseAuth.instance.currentUser.uid;
                      dbRespo.add(db);

                      CustomDialog.show(
                          message: "Cadastrado com sucesso!",
                          context: context,
                          error: false);
                    }
                  },
                  child: Text('Cadastrar'),
                ),
              ),
            ]),
          ),
        ),
      ),
      title: "Cadastro de bases",
      leading: false,
    );
  }

  Widget buildTextField(
      {String label,
      IconData icon,
      Function validator,
      bool obscure = false,
      TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.white,
          ),
          labelText: label,
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
        validator: (value) => validator(value),
      ),
    );
  }
}
