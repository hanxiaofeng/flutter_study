import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:flutterhello/provider/themeState.dart';
import 'package:provider/provider.dart';

void main() => runApp(new BaseWidget());

class BaseWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      home: new BaseWidHome(),
    );
  }
}

class BaseWidHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HomePage();
  }
}

class HomePage extends State {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        backgroundColor: Colors.white,
        appBar: new AppBar(
          title: new Text("基础组件"),
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.list),
                onPressed: () {
                  Toast.show("点我干嘛啊", context);
                })
          ],
        ),
        body: new Column(
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Text(
                  "changchao",
                ),
                new RaisedButton(
                  onPressed: () {
                    _changeTheme();
                  },
                  child: new Text("改变主题"),
                )
              ],
            ),
            new Row(
              children: <Widget>[
                new RaisedButton(
                  onPressed: () {
                    Toast.show('返回', context);
                    Navigator.pop(context);
                  },
                  child: new Text(
                    "返回上一页",
                  ),
                )
              ],
            )
          ],
        ));
  }

  void _changeTheme() {
    ThemeState themeState = Provider.of<ThemeState>(context, listen: false);
//    Toast.show('点击了我：'+themeState.stateMode.toString(), context);
    if(themeState.stateMode == 'dark'){
      Provider.of<ThemeState>(context, listen: false).updateThemeState('light');

    }else{
      Provider.of<ThemeState>(context, listen: false).updateThemeState('dark');
    }
  }
}
