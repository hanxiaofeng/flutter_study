import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutterhello/basewidget.dart';
import 'package:flutterhello/demo/NetRequest.dart';
import 'package:flutterhello/provider/themeState.dart';
import 'package:flutterhello/signature.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

void main() {
//  runApp(new MyApp());

  final themeState = ThemeState("dark");
  themeState.addListener(() {
    print("1111");
  });

  runApp(
    MultiProvider(
      providers: [
        /*ChangeNotifierProvider<ThemeState>.value(
          value: themeState,
          child: new HomeApp(),
        ),*/
        ChangeNotifierProvider<ThemeState>(
          create: (context) => ThemeState('dark'),
//          child: new HomeApp(),
        )
      ],
      child: new HomeApp(),
    ),
  );
}

class HomeApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new MyApp();
  }
}

class MyApp extends State {
  @override
  Widget build(BuildContext context) {
//    final wordPair = new WordPair.random();

    return new Container(
        child: Consumer<ThemeState>(
      builder: (context, theme, child) => Container(
        child: MaterialApp(
          title: "Demo",
          theme:
              theme.stateMode == 'dark' ? ThemeData.dark() : ThemeData.light(),
          home: new RandomWords(),
          routes: <String, WidgetBuilder>{
            '/base': (BuildContext context) => new BaseWidHome(),
            '/net': (BuildContext context) => new NetRequest(),
          },
        ),
      ),
    ));
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

  final _biggerFont = const TextStyle(fontSize: 18.0);

  final _saved = new Set<String>();

  void initData() {
    _demoList.add("Listview");
    _demoList.add("画板");
    _demoList.add("基础组件");
    _demoList.add("网络请求");
    _demoList.add("改变主题");
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _demoList.length * 2 - 1,
        itemBuilder: (context, i) {
          if (i.isOdd) return new Divider();
          final index = i ~/ 2;
          return _buildRow(_demoList[index], index);
        });
  }

  Widget _buildRow(String pair, int index) {

    return new ListTile(
      title: new Text(
        pair,
        style: _biggerFont,
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
        } else if (index == 4) {
          _changeTheme();
        }

      },
    );
  }

  @override
  Widget build(BuildContext context) {
//    final wordPair = new WordPair.random();

    return Consumer<ThemeState>(
      builder: (context, themeState, child) {
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
      },
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

  void _changeTheme() {
    ThemeState themeState = Provider.of<ThemeState>(context, listen: false);
    Toast.show('点击了我：' + themeState.stateMode.toString(), context);
    if (themeState.stateMode == 'dark') {
      Provider.of<ThemeState>(context, listen: false).updateThemeState('light');
    } else {
      Provider.of<ThemeState>(context, listen: false).updateThemeState('dark');
    }
  }
}
