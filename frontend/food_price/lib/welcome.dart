import 'package:flutter/material.dart';
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
      final snackBar = SnackBar(
        content: Text('Yay! A SnackBar!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start ,

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
    final titleText = Container(
      padding: EdgeInsets.all(20),
      child: Text(
        'Strawberry Pavlova',
        style: TextStyle(
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
          fontSize: 30,
        ),
      ),
    );

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
          titleText,
          // subTitle,
          // ratings,
          // iconList,
        ],
      ),
    );
    // #enddocregion leftColumn
  }
  Widget _singleItem (
      [String title = 'Oeschinen Lake Campground', String subtitle = 'Kandersteg, Switzerland']){
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start ,
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
            Icon(Icons.star, color: Colors.red[500],),
            Text('41'),
          ],
        ),
      ),
    );
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
    // return buildHomePage("abc");
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      // body: Center(child: Text('Welcome!', style: Theme.of(context).textTheme.headline2,),),
        body: Center(
            child: ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: 70, minHeight: 70, maxWidth: 1000, maxHeight: 800),
                child: Card(
                  margin: EdgeInsets.only(bottom: 100),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Food Name",style: Theme.of(context).textTheme.headline3,),
                              ),
                              Image.asset('../assets/testfood.jpg',scale: 0.2),]
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // 食材列表
                            Text('食材',style: Theme.of(context).textTheme.headline4,),
                            Expanded(
                              child: ListView.builder(
                                itemCount: 4,
                                itemBuilder: (_, int idx)=>ingredients[idx]),
                            ),
                          ],
                        ),
                      ),]),
                  )
                ))),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          margin: EdgeInsets.only(bottom: 50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FloatingActionButton.extended(
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

          // FloatingActionButton.extended(label: Text('test'),onPressed: () { return 0;}),
          // FloatingActionButton.extended(label: Text('test2'),onPressed: () { return 0;})],)
    );
  }
}