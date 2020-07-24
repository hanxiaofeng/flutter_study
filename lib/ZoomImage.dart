import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'estendImage/src/extended_image.dart';
import 'estendImage/src/extended_image_utils.dart';
import 'estendImage/src/gesture/extended_image_gesture_utils.dart';

void main() => runApp(new ZoomImage());

class ZoomImage extends StatelessWidget {

  String imageTestUrl;

  ZoomImage({this.imageTestUrl});

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new BaseWidHome(imageTestUrl: imageTestUrl,),
    );
  }
}

class BaseWidHome extends StatefulWidget {
  String imageTestUrl;
  BaseWidHome({this.imageTestUrl});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HomePage(imageTestUrl: imageTestUrl,);
  }
}

class HomePage extends State {

  String imageTestUrl;
  HomePage({this.imageTestUrl});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ExtendedImage.network(
      imageTestUrl,
      fit: BoxFit.contain,
      //enableLoadState: false,
      mode: ExtendedImageMode.gesture,
      initGestureConfigHandler: (state) {
        return GestureConfig(
          minScale: 0.9,
          animationMinScale: 0.7,
          maxScale: 3.0,
          animationMaxScale: 3.5,
          speed: 1.0,
          inertialSpeed: 100.0,
          initialScale: 1.0,
          inPageView: false,
          initialAlignment: InitialAlignment.center,
        );
      },
    );
  }
}
