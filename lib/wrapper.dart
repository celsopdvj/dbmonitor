import 'package:dbmonitor/pages/home.dart';
import 'package:dbmonitor/pages/login.dart';
import 'package:dbmonitor/scoped_models/userscopedmodel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class WrapperPage extends StatefulWidget {
  WrapperPage({Key key}) : super(key: key);

  @override
  _WrapperPageState createState() => _WrapperPageState();
}

class _WrapperPageState extends State<WrapperPage> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserScopedModel>(
      builder: (context, child, model) =>
          model.user == null ? LoginPage() : HomePage(),
    );
  }
}
