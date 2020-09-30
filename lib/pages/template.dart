import 'package:dbmonitor/custom_icons/icones_custom_icons.dart';
import 'package:dbmonitor/pages/advisor.dart';
import 'package:dbmonitor/pages/notifications.dart';
import 'package:dbmonitor/pages/performance.dart';
import 'package:dbmonitor/pages/reclaimablespace.dart';
import 'package:dbmonitor/pages/tablespace.dart';
import 'package:dbmonitor/pages/longops.dart';
import 'package:dbmonitor/pages/topsql.dart';
import 'package:dbmonitor/redux/globalvariables.dart';
import 'package:flutter/material.dart';

class TemplatePage extends StatelessWidget {
  final Widget body;
  final String title;
  final bool leading;

  const TemplatePage({this.body, this.title, this.leading = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.grey[850],
      ),
      backgroundColor: Colors.grey[850],
      body: this.body,
      drawer: !leading
          ? null
          : Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.grey[800],
              ),
              child: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    ListTile(
                      contentPadding: EdgeInsets.fromLTRB(15, 20, 5, 5),
                      leading: Icon(
                        Icons.storage,
                        color: Colors.white,
                      ),
                      title: Text(
                        GlobalVariables.database?.name ?? "NO DATABASE",
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {},
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Inicio',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.popUntil(context, ModalRoute.withName('/'));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        IconesCustom.speed,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Desempenho',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PerformancePage()));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.notifications,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Notificações',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotificationsPage()));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.table_chart,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Tablespaces',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TablespacePage()));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.hourglass_empty,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Long Operations',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Longops()));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.trending_up,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Top SQL',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Topsql()));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.wb_incandescent,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Advisor',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdvisorPage()));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.data_usage,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Reclaimable Space',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReclaimablespacePage()));
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}