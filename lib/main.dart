import 'package:dbmonitor/pages/databases.dart';
import 'package:dbmonitor/pages/login.dart';
import 'package:dbmonitor/pages/template.dart';
import 'package:dbmonitor/redux/globalvariables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dbmonitor/redux/globalvariables.dart' as gv;

import 'models/databasemodel.dart';
import 'pages/login.dart';
import 'pages/selectdb.dart';

void main() {
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
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          FirebaseUser user = snapshot.data;
          return SelectdbPage();
        }
        return LoginPage();
      },
    );
  }
}
