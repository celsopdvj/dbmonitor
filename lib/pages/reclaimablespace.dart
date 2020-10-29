import 'package:dbmonitor/pages/template.dart';
import 'package:flutter/material.dart';

class ReclaimablespacePage extends StatefulWidget {
  ReclaimablespacePage({Key key}) : super(key: key);

  @override
  _ReclaimablespacePageState createState() => _ReclaimablespacePageState();
}

class _ReclaimablespacePageState extends State<ReclaimablespacePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TemplatePage(
        title: "Reclaimable Space",
        body: Text("Reclaim"),
      ),
    );
  }
}
