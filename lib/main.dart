import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutterhello/basewidget.dart';
import 'package:flutterhello/demo/NetRequest.dart';
import 'package:flutterhello/signature.dart';
import 'package:toast/toast.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    final wordPair = new WordPair.random();

    return new MaterialApp(
      title: "Demo",
      theme: ThemeData.dark(),
//      theme: new ThemeData(primaryColor: Colors.white,platform: TargetPlatform.iOS),
      home: new RandomWords(),
      routes: <String, WidgetBuilder>{
        '/base': (BuildContext context) => new BaseWidHome(),
        '/net': (BuildContext context) => new NetRequest(),
      },
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RandomWordsState();
  }
}

class RandomWordsState extends State<RandomWords> {
  RandomWordsState() {
    initData();
  }

  final _demoList = new List<String>();

//  final _suggestions = <WordPair>[];

  final _biggerFont = const TextStyle(fontSize: 18.0);

  final _saved = new Set<String>();

  void initData() {
    _demoList.add("listview使用");
    _demoList.add("signature");
    _demoList.add("baseWidget");
    _demoList.add("netRequest");
    _demoList.add("测试4");
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _demoList.length * 2 - 1,
        itemBuilder: (context, i) {
          if (i.isOdd) return new Divider();

          final index = i ~/ 2;
          /*if(index >= _demoList.length){
            _suggestions.addAll(generateWordPairs().take(10));
          }*/
          return _buildRow(_demoList[index], index);
        });
  }

  Widget _buildRow(String pair, int index) {
    final alreadySaved = _saved.contains(pair);

    return new ListTile(
      title: new Text(
        pair,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
//                if(index == 0){
//        Toast.show("点击了$index", context);
//                }

        //跳转ListView
        if (index == 0) {
          _listview();
        } else if (index == 1) {
          _signature();
        } else if (index == 2) {
          _baseWidget();
        } else if (index == 3) {
          _netRequest();
        }

        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
//    final wordPair = new WordPair.random();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("start up name"),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: _buildSuggestions(),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
//          Toast.show("floating", context);
          _updateAction();
        },
        tooltip: "update text",
        child: new Icon(Icons.update),
      ),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map(
            (pair) {
              return new ListTile(
                title: new Text(
                  pair,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return new Scaffold(
            appBar: new AppBar(
              title: new Text("saved suggestions"),
            ),
            body: new ListView(
              children: divided,
            ),
          );
        },
      ),
    );
  }

  void _listview() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          final tiles = _demoList.map(
            (pair) {
              return new ListTile(
                title: new Text(
                  pair,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return new Scaffold(
            appBar: new AppBar(
              title: new Text("saved suggestions"),
            ),
            body: new ListView(
              children: divided,
              padding: EdgeInsets.all(8),
            ),
          );
        },
      ),
    );
  }

  void _signature() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new Scaffold(
            appBar: new AppBar(
              title: new Text("signature"),
            ),
            body: new Signature(),
          );
        },
      ),
    );
  }

  void _updateAction() {
    Toast.show("别点我啊", context);
  }

  void _baseWidget() {
    Navigator.of(context).pushNamed('/base');
  }

  void _netRequest() {
    Navigator.of(context).pushNamed('/net');
  }
}
