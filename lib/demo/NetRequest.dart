import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterhello/ZoomImage.dart';
import 'package:flutterhello/model/NetRequestModel.dart';
import 'package:flutterhello/video/full_video_page.dart';
import 'package:flutterhello/video/videoplay.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(new NetRequest());
}

enum PlayType {
  network,
  asset,
  file,
  fileId,
}

class NetRequest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NetPageHome netPageHome = new NetPageHome();
    return new Scaffold(
      appBar: AppBar(
        title: const Text("网络请求"),
      ),
      body: netPageHome,
    );
  }
}

class NetPageHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomePage();
  }
}

class HomePage extends State<NetPageHome> {
  List<Article> widgets = [];

  int pageNumber = 1;

  bool isLoading = false;

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    getMoreData(pageNumber);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        pageNumber++;
        getMoreData(pageNumber);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      /*appBar: new AppBar(
        title: new Text("网络请求"),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.list),
              onPressed: () {
                Toast.show("点我干嘛啊", context);
              })
        ],
      ),*/
      body: getBody(),
    );
  }

  getBody() {
    /*if (showLoadingDialog()) {
      return getProgressDialog();
    } else {*/
    return getListView();
//    }
  }

  Future onRefresh() {
    return Future.delayed(Duration(seconds: 1), () {
//      Toast.show('当前已是最新数据', context);
      pageNumber = 1;
      getMoreData(pageNumber);
    });
  }

  RefreshIndicator getListView() {
    return RefreshIndicator(
      child: new ListView.separated(
        scrollDirection: Axis.vertical,
        itemCount: widgets.length + 1,
        itemBuilder: (BuildContext context, int position) {
          if (position == widgets.length) {
            return _buildProgressIndicator();
          }
          return getRow(position);
        },
        controller: _scrollController,
        separatorBuilder: (BuildContext context, int index) {
          return new Divider(
            height: 1.0,
            color: Colors.blue,
          );
        },
      ),
      onRefresh: this.onRefresh,
    );

//    return new ListView.separated(
//      scrollDirection: Axis.vertical,
//      itemCount: widgets.length,
//      itemBuilder: (BuildContext context, int position) {
//        return getRow(position);
//      },
//      controller: _scrollController,
//      separatorBuilder: (BuildContext context, int index) {
//        return new Divider(
//          height: 1.0,
//          color: Colors.blue,
//        );
//      },
//    );
  }

  Widget getRow(int index) {
    return GestureDetector(
      child: new Column(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.all(10.0),
            child: new Text(" ${widgets[index].text}"),
          ),
          _getItemView(index),
          /*new Stack(
            alignment: Alignment.center,
            children: <Widget>[
              new FadeInImage.assetNetwork(
                placeholder: widgets[index].thumbnail,
                image: widgets[index].thumbnail,
                height: 300,
              ),
              new Container(
                width: 100,
                height: 100,
                child: new Image.asset("images/play.png"),
              ),
            ],
          )*/
//          new FullVideoPage(widgets[index].video,PlayType.network),
        ],
      ),

      /*child: new Padding(
        padding: new EdgeInsets.all(10.0),
        child: new Text(" ${widgets[index].text}"),
      ),*/
      onTap: () {
        Toast.show("点击了：${widgets[index].text}", context);

        if (widgets[index].type == "image") {
          _jumpZoomImage(widgets[index].images);
        } else {
          _jumpVideoPlay(widgets[index].video);
        }
      },
      onLongPress: () {
        Toast.show("长按了：${widgets[index].text}", context);
      },
    );

    /*return new Padding(
      padding: new EdgeInsets.all(10.0),
      child: new Text(" ${widgets[i].text}"),
    );*/
  }

  Widget _getItemView(int index) {
    if (widgets[index].type == "image") {
      return new Stack(
        alignment: Alignment.center,
        children: <Widget>[
          new FadeInImage.assetNetwork(
            placeholder: "images/placeholder.jpg",
            image: widgets[index].images,
            height: 300,
          ),
        ],
      );
    }
    return new Stack(
      alignment: Alignment.center,
      children: <Widget>[
        new FadeInImage.assetNetwork(
          placeholder: widgets[index].thumbnail,
          image: widgets[index].thumbnail,
          height: 300,
        ),
        new Container(
          width: 100,
          height: 100,
          child: new Image.asset("images/play.png"),
        ),
      ],
    );
  }

  void _jumpVideoPlay(String video) {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new Scaffold(
            /*appBar: new AppBar(
              title: new Text("signature"),
            ),*/
            body: new VideoPlay(videoUrl: video),
          );
        },
      ),
    );
  }

  void _jumpZoomImage(String imageUrl) {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new Scaffold(
            /*appBar: new AppBar(
              title: new Text("signature"),
            ),*/
            body: new ZoomImage(
              imageTestUrl: imageUrl,
            ),
          );
        },
      ),
    );
  }

  getProgressDialog() {
    return new Center(child: new CircularProgressIndicator());
  }

  showLoadingDialog() {
    if (widgets.length == 0) {
      return true;
    }
    return false;
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  getMoreData(int page) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      //&type=video
      String dataUrl = "http://api.apiopen.top/getJoke?page=" +
          page.toString() +
          "&count=20";
      print("dataUrl = " + dataUrl);
      Dio dio = new Dio();
      Response response = await dio.get(dataUrl);
      print("第" + page.toString() + "页数据：" + response.data.toString());
      setState(() {
        NetRequestModel netRequestModel = NetRequestModel.from(response.data);
        if (page == 1) {
          widgets.clear();
        }
        widgets.addAll(netRequestModel.result);
      });

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
