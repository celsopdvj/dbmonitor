import 'package:dbmonitor/pages/home.dart';
import 'package:dbmonitor/pages/login.dart';
import 'package:dbmonitor/redux/globalvariables.dart';
import 'package:dbmonitor/scoped_models/userscopedmodel.dart';
import 'package:dbmonitor/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'pages/login.dart';
import 'pages/selectdb.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DbMonitor',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'DbMonitor'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _userScopedModel = UserScopedModel();

  @override
  Widget build(BuildContext context) {
    GlobalVariables.context = context;
    return ScopedModel<UserScopedModel>(
        model: _userScopedModel, child: WrapperPage());
  }
}
