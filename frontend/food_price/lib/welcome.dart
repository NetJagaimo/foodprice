import 'package:flutter/material.dart';
import 'dart:ui' as ui;


class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  // void singupui(){
  //   ui.platformViewRegistry.registerViewFactory(
  //       'hello-html',
  //           (int viewId) => IFrameElement()
  //         ..width = '640'
  //         ..height = '360'
  //         ..src = 'https://www.youtube.com/embed/xg4S67ZvsRs'
  //         ..style.border = 'none');
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Center(child: Text('Welcome!', style: Theme.of(context).textTheme.headline2,),),
        body: Center(
            child: SizedBox(
                width: 800,
                height: 800,
                child: Card(
                  child: Image.network('https://tokyo-kitchen.icook.network/uploads/recipe/cover/373636/5dc990636b76eb32.jpg')
                ))));
  }
}