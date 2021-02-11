import 'package:dbmonitor/pages/advisor.dart';
import 'package:dbmonitor/pages/home.dart';
import 'package:dbmonitor/pages/login.dart';
import 'package:dbmonitor/pages/longops.dart';
import 'package:dbmonitor/pages/notifications.dart';
import 'package:dbmonitor/pages/performance.dart';
import 'package:dbmonitor/pages/selectdb.dart';
import 'package:dbmonitor/pages/tablespace.dart';
import 'package:dbmonitor/pages/topsql.dart';
import 'package:dbmonitor/redux/globalvariables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'custom_icons/icones_custom_icons.dart';

class WrapperPage extends StatefulWidget {
  final Widget body;
  final String title;
  final bool leading;
  final bool appBar;
  final bool signOut;

  const WrapperPage({
    this.body,
    this.title = "Home",
    this.leading = true,
    this.appBar = true,
    this.signOut = true,
  });

  @override
  _WrapperPageState createState() => _WrapperPageState();
}

class _WrapperPageState extends State<WrapperPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LoginPage();
          }
          return HomePage();
        });

    return FirebaseAuth.instance.currentUser == null ? LoginPage() : HomePage();
  }
}
