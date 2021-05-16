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

  final List<dataclass.MomoItems> _itemnames = [];

  Future<void> addAvailableItems() async {
    print(widget.ingredientName);
    var momoIngredients = await dataclass.getIngredientsFromMomo(widget.ingredientName);
    if (momoIngredients == null){return;}
    setState(() {
      for (dataclass.MomoItems item in momoIngredients.momoItems){
        _itemnames.add(item);
      }
    });
  }
  
  Widget _buildItemTile(dataclass.MomoItems item){
    return InkWell(
      onTap: (){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(item.link)));
      },
      child: Card(
        child: Column(children: [
          Expanded(child: dataclass.corsImage(item.imageLink, 150)),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Expanded(
                child: Text(item.name,
                  style: Theme.of(context).textTheme.bodyText1,),
              ),
              Text(item.price.toString(),)
            ],),
          )
        ],),
      ),
    );
  }


  @override
  void initState(){
    super.initState();
    addAvailableItems();
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: (_itemnames.length > 2)
              ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 3,
                ),
                itemCount: 6, //_itemnames.length, // TODO: To be changed in prod
                itemBuilder: (_,int idx)=>_buildItemTile(_itemnames[idx]))
              : Center(child: SizedBox(
                  width: 100,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        Text('Loading',
                          style: Theme.of(context).textTheme.headline6,)
                      ])
                )),
          )
          )
        ),
      ),
    );
  }
}
