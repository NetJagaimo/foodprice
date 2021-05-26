import 'dart:html';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'welcome.dart';
import 'dataclass.dart' as dataclass;

class PickItemScreen extends StatefulWidget {
  final String title = 'Pick Items';
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
      onTap: () async {
        if (await canLaunch(item.link)){
          await launch(item.link);
        }
        // Navigator.pop(context, item);
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(item.link)));
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
              Text('\$'+item.price.toString(), style: TextStyle(fontWeight: FontWeight.bold),)
            ],),
          )
        ],),
      ),
    );
  }

  Widget _buildGridViewOrLoading(){
    // TODO: make sure there are items to show
    return (_itemnames.length > 2)
        ? GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 3,
        ),
        itemCount: _itemnames.length, // TODO: To be changed in prod
        itemBuilder: (_,int idx)=>_buildItemTile(_itemnames[idx]))
        : CenterLoadingAnimation(context: context);
  }

  @override
  void initState(){
    super.initState();
    addAvailableItems();
  }

  @override
  Widget build(BuildContext context) {
    return MainFrame(
      title: widget.title,
      body:Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
          minWidth: 500, minHeight: 500, maxWidth: 1000, maxHeight: 800),
          child: Card(
          elevation: 2,
          margin: EdgeInsets.only(bottom: 100),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Row(children: [
                  Row(
                    children: [
                    Icon(Icons.shopping_bag,size: 30,),
                    Text(widget.ingredientName,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                        fontSize: 30,
                      ),
                    )],
                  ),
                Spacer(),
                Text('個數：'+_itemnames.length.toString())
                ],
              ),
              Divider(),
              Expanded(child: _buildGridViewOrLoading())
            ],)
          )
          )
        ),
      ),
    );
  }
}

class CenterLoadingAnimation extends StatelessWidget {
  const CenterLoadingAnimation({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Center(child: SizedBox(
    width: 100,
    child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          Text('Loading',
            style: Theme.of(context).textTheme.headline6,)
        ])
    ));
  }
}
