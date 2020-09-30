import 'package:dbmonitor/main.dart';
import 'package:dbmonitor/pages/template.dart';
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
        title: "Notificações",
        body: RefreshIndicator(
          onRefresh: refreshPage,
          child: ListView(
            children: [
              buildNotification(),
              buildNotification(),
              buildNotification(),
              buildNotification(),
              buildNotification(),
              buildNotification(),
              buildNotification(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNotification() {
    return Card(
      color: Colors.grey[800],
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Lock no banco de dados PRODUCAO",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                "Lock no banco de dados PRODUCAO. Usuário CELSO bloqueando o usuáro TESTE.",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              ButtonBarTheme(
                  data: ButtonBarThemeData(),
                  child: ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: const Text('LIMPAR'),
                        onPressed: criarNotificacao,
                      ),
                    ],
                  ))
            ]),
      ),
    );
  }
}
