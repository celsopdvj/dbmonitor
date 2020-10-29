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
  bool _selectAll = true;
  List<Categoria> categorias;

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
        title: "Notificações",
        body: RefreshIndicator(
          onRefresh: refreshPage,
          child: FutureBuilder(
              future: notificationsReq.fetchNotifications(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<NotificationsModel> dados = snapshot.data;
                  if (categorias == null)
                    categorias = dados
                        .map((e) => e.mESSAGETYPE)
                        .toSet()
                        .map((e) => Categoria(e, true))
                        .toList();
                  return ListView(
                    children: [
                      buildFilter(),
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
    if (!categorias.any((c) => c.tipo == sql.mESSAGETYPE && c.selected)) {
      return Container();
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Card(
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
      ),
    );
  }

  Widget buildFilter() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: ExpandableNotifier(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                ScrollOnExpand(
                  scrollOnExpand: false,
                  scrollOnCollapse: false,
                  child: Container(
                    color: Colors.grey[800],
                    child: ExpandablePanel(
                      theme: const ExpandableThemeData(
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                        tapBodyToCollapse: true,
                        iconColor: Colors.white,
                      ),
                      header: Container(
                        child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              "Filtros",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.2,
                                  fontSize: 18),
                            )),
                      ),
                      expanded: categorias == null
                          ? Container()
                          : Container(
                              height: MediaQuery.of(context).size.height * .3,
                              child: ListView(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectAll = !_selectAll;
                                        categorias.forEach((element) {
                                          element.selected = _selectAll;
                                        });
                                      });
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 15),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Selecionar todos",
                                            style: TextStyle(
                                              color: Colors.white,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                          Theme(
                                            data: Theme.of(context).copyWith(
                                              unselectedWidgetColor:
                                                  Colors.white,
                                            ),
                                            child: Checkbox(
                                              activeColor: Colors.white,
                                              checkColor: Colors.black,
                                              value: _selectAll,
                                              onChanged: (bool value) {
                                                setState(() {
                                                  _selectAll = value;
                                                  categorias.forEach((element) {
                                                    element.selected =
                                                        _selectAll;
                                                  });
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.white,
                                  ),
                                  ...categorias
                                      .asMap()
                                      .map((i, Categoria e) => MapEntry(
                                            i,
                                            buildCheckBox(e, i),
                                          ))
                                      .values
                                      .toList(),
                                ],
                              ),
                            ),
                      builder: (_, collapsed, expanded) {
                        return Padding(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          child: Expandable(
                            collapsed: collapsed,
                            expanded: expanded,
                            theme: const ExpandableThemeData(crossFadePoint: 0),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCheckBox(Categoria e, int i) {
    return GestureDetector(
      onTap: () {
        setState(() {
          categorias[i].selected = !categorias[i].selected;
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              e.tipo,
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1,
              ),
            ),
            Theme(
              data: Theme.of(context).copyWith(
                unselectedWidgetColor: Colors.white,
              ),
              child: Checkbox(
                activeColor: Colors.white,
                checkColor: Colors.black,
                value: e.selected,
                onChanged: (bool value) {
                  setState(() {
                    categorias[i].selected = value;
                  });
                },
              ),
            ),
          ],
        ),
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

class Categoria {
  String tipo;
  bool selected;

  Categoria(this.tipo, this.selected);
}
