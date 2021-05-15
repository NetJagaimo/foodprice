import 'dart:html';

import 'package:flutter/material.dart';
import 'welcome.dart';
import 'dataclass.dart' as dataclass;

class PickItemScreen extends StatefulWidget {
  final String ingredientName;
  const PickItemScreen({Key key, @required this.ingredientName}) : super(key: key);

  @override
  _PickItemScreenState createState() => _PickItemScreenState();
}

class _PickItemScreenState extends State<PickItemScreen> {

  final List<String> _itemnames = [];

  Future<void> showAvailableItems() async {
    print(widget.ingredientName);
    var momoIngredients = await dataclass.getIngredientsFromMomo(widget.ingredientName);
    setState(() {
      for (dataclass.MomoItems item in momoIngredients.momoItems){
        _itemnames.add(item.imageLink);
      }
    });
  }


  @override
  void initState(){
    super.initState();
    showAvailableItems();
  }

  @override
  Widget build(BuildContext context) {
    return MainFrame(body:
      Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
          minWidth: 500, minHeight: 500, maxWidth: 1000, maxHeight: 800),
          child: Card(
          elevation: 2,
          margin: EdgeInsets.only(bottom: 100),
          child: ListView.builder(
              itemCount: (_itemnames.length > 2) ? 2 : _itemnames.length,
              itemBuilder: (_,int idx)=>dataclass.corsImage(_itemnames[idx]))
          )
        ),
      ),
    );
  }
}
