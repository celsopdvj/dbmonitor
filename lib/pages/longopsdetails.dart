import 'package:dbmonitor/pages/template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';

class LongopsdetailsPage extends StatefulWidget {
  LongopsdetailsPage({Key key}) : super(key: key);

  @override
  _LongopsdetailsPageState createState() => _LongopsdetailsPageState();
}

class _LongopsdetailsPageState extends State<LongopsdetailsPage> {
  String sqlText =
      "SELECT table_owner,\n       table_name,\n       owner AS index_owner,\n       index_name,\n       tablespace_name,\n       num_rows,\n       status,\n       index_type\nFROM   dba_indexes\nWHERE  table_owner = UPPER('&1')\nAND    table_name = DECODE(UPPER('&2'), 'ALL', table_name, UPPER('&2'))\nORDER BY table_owner, table_name, index_owner, index_name;";

  static final customTheme = {
    'root':
        TextStyle(backgroundColor: Colors.grey[850], color: Color(0xffdddddd)),
    'tag': TextStyle(color: Color(0xfff92672)),
    'keyword': TextStyle(color: Color(0xfff92672), fontWeight: FontWeight.bold),
    'selector-tag':
        TextStyle(color: Color(0xfff92672), fontWeight: FontWeight.bold),
    'literal': TextStyle(color: Color(0xfff92672), fontWeight: FontWeight.bold),
    'strong': TextStyle(color: Color(0xfff92672)),
    'name': TextStyle(color: Color(0xfff92672)),
    'code': TextStyle(color: Color(0xff66d9ef)),
    'attribute': TextStyle(color: Color(0xffbf79db)),
    'symbol': TextStyle(color: Color(0xffbf79db)),
    'regexp': TextStyle(color: Color(0xffbf79db)),
    'link': TextStyle(color: Color(0xffbf79db)),
    'string': TextStyle(color: Color(0xffa6e22e)),
    'bullet': TextStyle(color: Color(0xffa6e22e)),
    'subst': TextStyle(color: Color(0xffa6e22e)),
    'title': TextStyle(color: Color(0xffa6e22e), fontWeight: FontWeight.bold),
    'section': TextStyle(color: Color(0xffa6e22e), fontWeight: FontWeight.bold),
    'emphasis': TextStyle(color: Color(0xffa6e22e)),
    'type': TextStyle(color: Color(0xffa6e22e), fontWeight: FontWeight.bold),
    'built_in': TextStyle(color: Color(0xffa6e22e)),
    'builtin-name': TextStyle(color: Color(0xffa6e22e)),
    'selector-attr': TextStyle(color: Color(0xffa6e22e)),
    'selector-pseudo': TextStyle(color: Color(0xffa6e22e)),
    'addition': TextStyle(color: Color(0xffa6e22e)),
    'variable': TextStyle(color: Color(0xffa6e22e)),
    'template-tag': TextStyle(color: Color(0xffa6e22e)),
    'template-variable': TextStyle(color: Color(0xffa6e22e)),
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
      title: "Detalhes da operação",
      leading: false,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Text(
              "SQL ID: cn7k9ndh900sp",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
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
