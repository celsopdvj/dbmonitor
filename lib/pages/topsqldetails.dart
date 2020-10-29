import 'package:dbmonitor/pages/template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';

class TopsqlDetailsPage extends StatefulWidget {
  final String sqlText;
  final String sqlId;

  TopsqlDetailsPage(this.sqlText, this.sqlId, {Key key}) : super(key: key);

  @override
  _TopsqlDetailsPageState createState() =>
      _TopsqlDetailsPageState(sqlText, sqlId);
}

class _TopsqlDetailsPageState extends State<TopsqlDetailsPage> {
  final String sqlText;
  final String sqlId;

  _TopsqlDetailsPageState(this.sqlText, this.sqlId);

  static final customTheme = {
    'root':
        TextStyle(backgroundColor: Colors.grey[850], color: Color(0xffdddddd)),
    'tag': TextStyle(color: Color(0xff3978DE)),
    'keyword': TextStyle(color: Color(0xff3978DE), fontWeight: FontWeight.bold),
    'selector-tag':
        TextStyle(color: Color(0xff3978DE), fontWeight: FontWeight.bold),
    'literal': TextStyle(color: Color(0xff3978DE), fontWeight: FontWeight.bold),
    'strong': TextStyle(color: Color(0xff3978DE)),
    'name': TextStyle(color: Color(0xff3978DE)),
    'code': TextStyle(color: Color(0xff66d9ef)),
    'attribute': TextStyle(color: Color(0xffbf79db)),
    'symbol': TextStyle(color: Color(0xffbf79db)),
    'regexp': TextStyle(color: Color(0xffbf79db)),
    'link': TextStyle(color: Color(0xffbf79db)),
    'string': TextStyle(color: Color(0xffffbf00)),
    'bullet': TextStyle(color: Color(0xffffbf00)),
    'subst': TextStyle(color: Color(0xffffbf00)),
    'title': TextStyle(color: Color(0xffffbf00), fontWeight: FontWeight.bold),
    'section': TextStyle(color: Color(0xffffbf00), fontWeight: FontWeight.bold),
    'emphasis': TextStyle(color: Color(0xffffbf00)),
    'type': TextStyle(color: Color(0xffffbf00), fontWeight: FontWeight.bold),
    'built_in': TextStyle(color: Color(0xffffbf00)),
    'builtin-name': TextStyle(color: Color(0xffffbf00)),
    'selector-attr': TextStyle(color: Color(0xffffbf00)),
    'selector-pseudo': TextStyle(color: Color(0xffffbf00)),
    'addition': TextStyle(color: Color(0xffffbf00)),
    'variable': TextStyle(color: Color(0xffffbf00)),
    'template-tag': TextStyle(color: Color(0xffffbf00)),
    'template-variable': TextStyle(color: Color(0xffffbf00)),
    'comment': TextStyle(color: Color(0xff75715e)),
    'quote': TextStyle(color: Color(0xff75715e)),
    'deletion': TextStyle(color: Color(0xff75715e)),
    'meta': TextStyle(color: Color(0xff75715e)),
    'doctag': TextStyle(fontWeight: FontWeight.bold),
    'selector-id': TextStyle(fontWeight: FontWeight.bold),
  };

  @override
  Widget build(BuildContext context) {
    return TemplatePage(
      context,
      title: "Detalhes do SQL",
      leading: false,
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: "SQL ID: ",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  TextSpan(
                    text: this.sqlId,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: HighlightView(
              sqlText,
              language: 'sql',
              theme: customTheme,
              padding: EdgeInsets.all(12),
              textStyle: TextStyle(
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}
