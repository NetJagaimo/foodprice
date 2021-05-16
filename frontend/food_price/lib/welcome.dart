import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:transparent_image/transparent_image.dart';
import 'pickitem.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'dart:ui' as ui;
import 'dataclass.dart' as dataclass;

class IngredientTile extends StatelessWidget {
  IngredientTile([this.name = 'Oeschinen Lake Campground', this.unit = 'Kandersteg, Switzerland', this.callback]);
  final String name;
  final String unit;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        callback(name);
      // final snackBar = SnackBar(
      //   content: Text('Yay! A SnackBar!'));
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.bold,),
                  ),
                ),
              ],
            ),
            Spacer(),
            Text(
              unit,
              style: TextStyle(color: Colors.grey[500],),
            )
          ],
        ),
      ),
    );
  }
}

class RecipeScreen extends StatefulWidget {
  final String url;
  final String name;
  final String imgUrl;
  RecipeScreen({this.url, this.name, this.imgUrl});

  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {

  List<dataclass.MomoItems> itemsList = [];

  Widget buildHomePage(String title) {
    final subTitle = Text(
      'Pavlova is a meringue-based dessert named after the Russian ballerina '
          'Anna Pavlova. Pavlova features a crisp crust and soft, light inside, '
          'topped with fruit and whipped cream.',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Georgia',
        fontSize: 25,
      ),
    );

    // #docregion ratings, stars
    var stars = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star, color: Colors.green[500]),
        Icon(Icons.star, color: Colors.green[500]),
        Icon(Icons.star, color: Colors.green[500]),
        Icon(Icons.star, color: Colors.black),
        Icon(Icons.star, color: Colors.black),
      ],
    );
    // #enddocregion stars

    final ratings = Container(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          stars,
          Text(
            '170 Reviews',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontFamily: 'Roboto',
              letterSpacing: 0.5,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
    // #enddocregion ratings

    // #docregion iconList
    final descTextStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w800,
      fontFamily: 'Roboto',
      letterSpacing: 0.5,
      fontSize: 18,
      height: 2,
    );

    // DefaultTextStyle.merge() allows you to create a default text
    // style that is inherited by its child and all subsequent children.
    final iconList = DefaultTextStyle.merge(
      style: descTextStyle,
      child: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Icon(Icons.kitchen, color: Colors.green[500]),
                Text('PREP:'),
                Text('25 min'),
              ],
            ),
            Column(
              children: [
                Icon(Icons.timer, color: Colors.green[500]),
                Text('COOK:'),
                Text('1 hr'),
              ],
            ),
            Column(
              children: [
                Icon(Icons.restaurant, color: Colors.green[500]),
                Text('FEEDS:'),
                Text('4-6'),
              ],
            ),
          ],
        ),
      ),
    );
    // #enddocregion iconList

    // #docregion leftColumn
    final leftColumn = Container(
      //padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
      child: Column(
        children: [
          //titleText,
          // subTitle,
          // ratings,
          // iconList,
        ],
      ),
    );
    // #enddocregion leftColumn
  }

  List<Widget> ingredients = [];

  Future<void> _buildRecipe() async {
    var recipe = await dataclass.parseRecipeJson(widget.url);
    setState(() {
      for (dataclass.RecipeDetail r in recipe.recipeDetail){
        if (r.ingredients.isNotEmpty){
          ingredients.add(
              Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: Text(r.groupName,
                  style: Theme.of(context).textTheme.headline5,
          ),
              ));
          for (dataclass.Ingredient ing in r.ingredients){
            ingredients.add(IngredientTile(ing.name, ing.unit, _itemSelectedCallBack));
          }
        }
      }
    });
  }
  void _itemSelectedCallBack(String name) async {
    dataclass.MomoItems selectedItem = await Navigator.push(context, MaterialPageRoute(
        builder: (context)=> PickItemScreen(ingredientName: name,)));
    if (selectedItem != null){
      itemsList.add(selectedItem);
      print(selectedItem.link);
    }
  }
  @override
  void initState(){
    super.initState();
    _buildRecipe();
  }

  @override
  Widget build(BuildContext context) {
    return MainFrame(
      title: widget.name,
      body: Center(child:buildRecipeScreen(context)),
    //   nextPage: if (itemsList.isNotEmpty) {
    //     Navigator.push(context, MaterialPageRoute(
    //       builder: (context)=> ConcludeScreen(itemnames: itemsList)))
    //
    );
  }

  CenterBox buildRecipeScreen(BuildContext context) {
    return CenterBox(ingredients: ingredients, name: widget.name, imgUrl: widget.imgUrl);
  }
}
class MainFrame extends StatelessWidget {
  const MainFrame({
    Key key, this.body, this.nextPage, this.title
  }) : super(key: key);
  final Widget body;
  final String title;
  final Widget nextPage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title),automaticallyImplyLeading: false,),
      // backgroundColor: Colors.orangeAccent,
      // body: Center(child: Text('Welcome!', style: Theme.of(context).textTheme.headline2,),),
        body: body,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          margin: EdgeInsets.only(bottom: 50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FloatingActionButton.extended(
                heroTag: null,
                label: Text('上一頁'),
                onPressed: ()=> Navigator.pop(context),
                icon: Icon(Icons.navigate_before),
              ),
              if (nextPage != null) FloatingActionButton.extended(
                label: Text('下一頁'),
                onPressed: ()=>Navigator.push(
                    context, MaterialPageRoute(builder: (context)=> nextPage)), // TODO: put next step in it.
                icon: Icon(Icons.navigate_next),
                )
              ],
            ),
          ),
        )
    );
  }
}

class CenterBox extends StatefulWidget {
  const CenterBox({
    Key key,
    @required this.ingredients, this.name, this.imgUrl
  }) : super(key: key);

  final List<Widget> ingredients;
  final String name, imgUrl;

  @override
  _CenterBoxState createState() => _CenterBoxState();
}

class _CenterBoxState extends State<CenterBox> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          minWidth: 70, minHeight: 70, maxWidth: 1000, maxHeight: 800),
      child: Card(
        elevation: 2,
        margin: EdgeInsets.only(bottom: 100),
        child: buildRecipe(context)
      ));
  }

  Padding buildRecipe(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
          Expanded(
            flex: 2,
            child: buildLeftColumn(widget.name, widget.imgUrl),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 食材列表
                Text('食材',style: Theme.of(context).textTheme.headline4,),
                Divider(thickness: 2,),
                ingredientsList(ingredients: widget.ingredients),
              ],
            ),
          ),]),
      );
  }

  Container buildLeftColumn(String name, String url) {
    String _parseUrl(String oriUrl){
      return env['CORS_PROXY'] + env['COMPRESSOR'] + oriUrl;
    }
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(name,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                      fontSize: 30,
                    ))
              //style: Theme.of(context).textTheme.headline3,),
            ),
            //Image.asset('../assets/testfood.jpg',scale: 0.2),]
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(_parseUrl(widget.imgUrl),
                  headers: {'X-Requested-With':'XMLHttpRequest'}),
            ),
            // NOTE: this is non-fade image
            // Image.network(
            //   _parseUrl(url),
            //   headers: {'X-Requested-With':'XMLHttpRequest'}),
          ]),
    );
  }
}

class ingredientsList extends StatelessWidget {
  const ingredientsList({
    Key key,
    @required this.ingredients,
  }) : super(key: key);

  final List<Widget> ingredients;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: (ingredients.isNotEmpty)
        ? ListView.builder(
            itemCount: ingredients.length,
            itemBuilder: (_, int idx)=>ingredients[idx])
        : CenterLoadingAnimation(context: context),
    );
  }
}