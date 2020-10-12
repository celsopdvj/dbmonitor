import 'package:dbmonitor/pages/template.dart';
import 'package:flutter/material.dart';

class CadastroPage extends StatefulWidget {
  CadastroPage({Key key}) : super(key: key);

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  @override
  Widget build(BuildContext context) {
    return TemplatePage(
      body: Text("Cadastro"),
      title: "Cadastro",
      leading: false,
    );
  }
}
