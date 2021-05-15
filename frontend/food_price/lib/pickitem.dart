import 'package:flutter/material.dart';

class PickItem extends StatefulWidget {
  const PickItem({Key key}) : super(key: key);

  @override
  _PickItemState createState() => _PickItemState();
}

class _PickItemState extends State<PickItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recipe'),automaticallyImplyLeading: false,),
      // backgroundColor: Colors.orangeAccent,
      // body: Center(child: Text('Welcome!', style: Theme.of(context).textTheme.headline2,),),
      body: Center(
      child: ConstrainedBox(
      constraints: BoxConstraints(
      minWidth: 70, minHeight: 70, maxWidth: 1000, maxHeight: 800),))
    );
  }
}
