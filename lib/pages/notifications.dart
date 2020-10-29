import 'package:dbmonitor/api_models/notificationsmodel.dart';
import 'package:dbmonitor/api_requests/notificationsreq.dart';
import 'package:dbmonitor/pages/template.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsPage extends StatefulWidget {
  NotificationsPage({Key key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<Null> refreshPage() {
    return Future.delayed(Duration(seconds: 1), () => null);
  }

  NotificationsRequest notificationsReq;
  ExpandableController _controller;

  @override
  void initState() {
    super.initState();
    notificationsReq = NotificationsRequest();
    _controller = ExpandableController();
  }

  void criarNotificacao() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      //Navigator.popUntil(context, ModalRoute.withName('/'));
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => NotificationsPage()));
    });

    var android = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        importance: Importance.Max,
        priority: Priority.High,
        styleInformation: BigTextStyleInformation(""));
    var iOS = new IOSNotificationDetails();
    var plataform = new NotificationDetails(android, iOS);
    var scheduledNotificationDateTime =
        DateTime.now().add(Duration(seconds: 10));
    await flutterLocalNotificationsPlugin.schedule(
        0,
        "Lock no banco de dados PRODUCAO",
        "Lock no banco de dados PRODUCAO. Usuário CELSO bloqueando o usuáro TESTE.",
        scheduledNotificationDateTime,
        plataform,
        androidAllowWhileIdle: true);
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.popUntil(context, ModalRoute.withName('/'));
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NotificationsPage()));
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TemplatePage(
        context,
        title: "Notificações",
        body: RefreshIndicator(
          onRefresh: refreshPage,
          child: FutureBuilder(
              future: notificationsReq.fetchNotifications(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<NotificationsModel> dados = snapshot.data;
                  return ListView(
                    children: [
                      ...dados.map((e) => buildNotification(e)).toList()
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

  Widget buildNotification(NotificationsModel sql) {
    return Card(
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
                        text: sql.cREATIONTIME,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber),
                      ),
                    ],
                  ),
                ),
              ),
              buildCorpo(sql),
            ]),
      ),
    );
  }

  Widget buildCorpo(NotificationsModel sql) {
    return Column(
      children: [
        ExpandableNotifier(
          controller: _controller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ScrollOnExpand(
                scrollOnExpand: false,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: false,
                    tapBodyToExpand: false,
                    iconColor: Colors.white,
                  ),
                  collapsed: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Motivo: ",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${sql.rEASON}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Ação sugerida: ",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${sql.sUGGESTEDACTION}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Último valor: ",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          Text(
                            "${sql.mETRICVALUE}",
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
                            "Nível: ",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          Text(
                            "${sql.mESSAGETYPE}",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        color: Colors.amber,
                        icon: Icon(Icons.keyboard_arrow_down),
                        onPressed: () =>
                            _controller.expanded = !_controller.expanded,
                      ),
                    ],
                  ),
                  expanded: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: "Motivo: ",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          TextSpan(
                            text: sql.rEASON,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ]),
                      ),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: "Ação sugerida: ",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          TextSpan(
                            text: sql.sUGGESTEDACTION,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ]),
                      ),
                      Row(
                        children: [
                          Text(
                            "Último valor: ",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          Text(
                            "${sql.mETRICVALUE}",
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
                            "Nível: ",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          Text(
                            "${sql.mESSAGETYPE}",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        color: Colors.amber,
                        icon: Icon(Icons.keyboard_arrow_up),
                        onPressed: () =>
                            _controller.expanded = !_controller.expanded,
                      ),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                      theme: const ExpandableThemeData(crossFadePoint: 0),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
