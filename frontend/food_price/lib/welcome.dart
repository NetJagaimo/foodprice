import 'package:flutter/material.dart';
import 'pickitem.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'dart:ui' as ui;


class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}
class Ingredient extends StatelessWidget {
  Ingredient([this.title = 'Oeschinen Lake Campground' , this.subtitle = 'Kandersteg, Switzerland']);
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> PickItem()));
      // final snackBar = SnackBar(
      //   content: Text('Yay! A SnackBar!'));
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold,),
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey[500],),
                ),
              ],
            ),
            Spacer(),
            Icon(Icons.star, color: Colors.red[500],),
            Text('41'),
          ],
        ),
      ),
    );
  }
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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
  void _buildTestList(){
    ingredients.add(Ingredient('Ingredient1', 'good for health'));
    ingredients.add(Ingredient('Ingredient1', 'good for health'));
    ingredients.add(Ingredient('Ingredient1', 'good for health'));
    ingredients.add(Ingredient());
    ingredients.add(Ingredient());
  }

  @override
  Widget build(BuildContext context) {
    _buildTestList();
    return MainFrame(
      body: Center(child:buildRecipeScreen(context)),
    );
  }

  CenterBox buildRecipeScreen(BuildContext context) {
    return CenterBox(ingredients: ingredients);
  }
}
class MainFrame extends StatelessWidget {
  const MainFrame({
    Key key, this.body
  }) : super(key: key);
  final Widget body;
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
                label: Text('test'),
                onPressed: ()=> Navigator.pop(context),
                icon: Icon(Icons.navigate_before),
              ),
              FloatingActionButton.extended(
                label: Text('test'),
                onPressed: () {},
                icon: Icon(Icons.navigate_next),
                )
              ],
            ),
          ),
        )
    );
  }
}

class CenterBox extends StatelessWidget {
  const CenterBox({
    Key key,
    @required this.ingredients,
  }) : super(key: key);

  final List<Widget> ingredients;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          minWidth: 70, minHeight: 70, maxWidth: 1000, maxHeight: 800),
      child: Card(
        elevation: 2,
        margin: EdgeInsets.only(bottom: 100),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
            Expanded(
              flex: 2,
              child: buildLeftColumn('https://imageproxy.icook.network/resize?background=255%2C255%2C255&height=600&nocrop=false&stripmeta=true&type=auto&url=http%3A%2F%2Ftokyo-kitchen.icook.tw.s3.amazonaws.com%2Fuploads%2Frecipe%2Fcover%2F351486%2Fd8148f07fe50e2d1.jpg&width=600'),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 食材列表
                  Text('食材',style: Theme.of(context).textTheme.headline4,),
                  ingredientsList(ingredients: ingredients),
                ],
              ),
            ),]),
        )
      ));
  }

  Container buildLeftColumn(String url) {
    String _parseUrl(String oriUrl){
      var reavelUrl = oriUrl.split("url=")[1].split('width=')[0];
      print(Uri.decodeFull(reavelUrl));
      return 'https://api.allorigins.win/raw?url=' + Uri.decodeFull(reavelUrl);
    }
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Food Name",
                    style: TextStyle(

                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                      fontSize: 30,
                    ))
              //style: Theme.of(context).textTheme.headline3,),
            ),
            //Image.asset('../assets/testfood.jpg',scale: 0.2),]
            Image.network(
              _parseUrl(url)
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
        itemCount: 4,
        itemBuilder: (_, int idx)=>ingredients[idx]),
    );
  }
}