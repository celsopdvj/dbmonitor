import 'package:dbmonitor/api_requests/notificationsreq.dart';
import 'package:dbmonitor/models/databasemodel.dart';
import 'package:dbmonitor/pages/selectdb.dart';
import 'package:dbmonitor/pages/template.dart';
import 'package:dbmonitor/repositories/databaserepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dbmonitor/redux/globalvariables.dart' as gv;

import 'notifications.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NotificationsRequest notificationsReq;
  var dbRepo = DatabaseRepository();

  @override
  void initState() {
    super.initState();
    notificationsReq = NotificationsRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TemplatePage(
        title: "DbMonitor",
        body: Column(
          children: <Widget>[
            buildCard(
                informacao: gv.GlobalVariables.userName == null
                    ? "Nenhum usuário logado"
                    : gv.GlobalVariables.userName,
                icone: Icons.person),
            buildCard(
                informacao: gv.GlobalVariables.email == null
                    ? "Nenhum usuário logado"
                    : gv.GlobalVariables.email,
                icone: Icons.email),
            buildCard(
              builder: FutureBuilder(
                future: notificationsReq.fetchNotifications(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data.length.toString() +
                          " notificaç" +
                          (snapshot.data.length != 1 ? "ões" : "ão"),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        letterSpacing: 1.2,
                      ),
                    );
                  }
                  return Text(
                    "Carregando",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      letterSpacing: 1.2,
                    ),
                  );
                },
              ),
              icone: Icons.notifications_active,
              click: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NotificationsPage())),
            ),
            buildCard(
                informacao: gv.GlobalVariables.database == null
                    ? "Nenhum banco de dados selecionado"
                    : gv.GlobalVariables.database.name,
                icone: Icons.storage,
                click: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SelectdbPage()))),
          ],
        ),
      ),
    );
  }

  Widget buildCard({String informacao, IconData icone, builder, click}) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey[800], boxShadow: [
        BoxShadow(
          color: Colors.grey[900],
          blurRadius: 25.0,
          spreadRadius: 3.0,
          offset: Offset(
            15.0,
            5.0,
          ),
        )
      ]),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: GestureDetector(
        onTap: click,
        child: Row(
          children: [
            Container(
              width: 50,
              child: Icon(icone, color: Colors.amber),
            ),
            Container(
              child: builder != null
                  ? builder
                  : Text(
                      informacao,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        letterSpacing: 1.2,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
