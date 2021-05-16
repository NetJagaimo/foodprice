import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'pickitem.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'dart:ui' as ui;
import 'dataclass.dart' as dataclass;


class RecipeScreen extends StatefulWidget {
  final String url, name, imgUrl;
  RecipeScreen(this.url, this.name, this.imgUrl);

  @override
  _RecipeScreenState createState() => _RecipeScreenState(this.url, this.name, this.imgUrl);
}
class IngredientTile extends StatelessWidget {
  IngredientTile([this.title = 'Oeschinen Lake Campground', this.subtitle = 'Kandersteg, Switzerland']);
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> PickItemScreen(ingredientName: title,)));
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
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold,),
                  ),
                ),
              ],
            ),
            Spacer(),
            Text(
              subtitle,
              style: TextStyle(color: Colors.grey[500],),
            )
          ],
        ),
      ),
    );
  }
}

class _RecipeScreenState extends State<RecipeScreen> {
  final String url, name, imgUrl;
  _RecipeScreenState(this.url, this.name, this.imgUrl);

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
    var recipe = await dataclass.parseRecipeJson(this.url);
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
            ingredients.add(IngredientTile(ing.name, ing.unit));
          }
        }
      }
    });
  }
  @override
  void initState(){
    super.initState();
    _buildRecipe();
  }

  @override
  Widget build(BuildContext context) {
    return MainFrame(
      body: Center(child:buildRecipeScreen(context)),
    );
  }

  CenterBox buildRecipeScreen(BuildContext context) {
    return CenterBox(ingredients: ingredients, name: this.name, imgUrl: this.imgUrl);
  }
}
class MainFrame extends StatelessWidget {
  const MainFrame({
    Key key, this.body, this.nextPage
  }) : super(key: key);
  final Widget body;
  final Widget nextPage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recipe'),automaticallyImplyLeading: false,),
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
              FloatingActionButton.extended(
                label: Text('下一頁'),
                onPressed: ()=> (nextPage != null) ? Navigator.push(
                    context, MaterialPageRoute(builder: (context)=> nextPage))
                : null, // TODO: put next step in it.
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
      return env['CORS_PROXY'] + oriUrl;
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
            Image.network(
              _parseUrl(url),
              headers: {'X-Requested-With':'XMLHttpRequest'}
              ,)
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
      child: ListView.builder(
        itemCount: ingredients.length,
        itemBuilder: (_, int idx)=>ingredients[idx]),
    );
  }
}