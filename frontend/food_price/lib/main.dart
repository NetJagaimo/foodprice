import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'recipe.dart';
import 'welcome.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'dataclass.dart' as dataclass;

void main() async{
  await DotEnv.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Link',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        textTheme: GoogleFonts.notoSansTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.orange,
      ),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        '/': (context) => MyHomePage(title: 'Recipe Link'),
        // Placeholder // ToBeRemoved:
        '/welcome': (context) => RecipeScreen(url:'https://icook.tw/recipes/373706', name: 'Recipe',
            imgUrl:'http://tokyo-kitchen.icook.tw.s3.amazonaws.com/uploads/recipe/cover/372446/908fcbfc4588b161.jpg'),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // This list holds the data for the list view
  List<dataclass.RecipeSummary> _shownRecipes = [];

  final _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isComposing = false;
  bool _searched = false; // at the beginning, remove no result found text.

  @override
  initState() {
    super.initState();
  }

  void _runFilter(String enteredKeyword) async{
    _searched = true;
    List<dataclass.RecipeSummary> results = [];
    var recipeSearchResult = await dataclass.searchRecipes(enteredKeyword, 1); // TODO: Add page

    if (enteredKeyword.isNotEmpty&&recipeSearchResult.recipes!=null) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = recipeSearchResult.recipes;
    }

    setState(() { // Refresh the UI
      _shownRecipes = results;
    });
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: FractionallySizedBox(
        widthFactor: 0.5,
        child: Container(
          padding: EdgeInsets.all(12),
          //margin: EdgeInsets.all(10.0),
          child: Row(
            children: [
              Flexible(
                child: TextField(
                  cursorHeight: 20,
                  onChanged: (String text) {
                    setState(() {
                      _isComposing = text.isNotEmpty;
                    });
                  },
                  focusNode: _focusNode,
                  controller: _textController,
                  onSubmitted: _isComposing ? _runFilter : null,
                  decoration:
                  InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
                    border: OutlineInputBorder(),
                    hintText: "Type some dish name like: Pot Sticker"),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                child: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _isComposing
                        ? () => _runFilter(_textController.text)
                        : null),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _handleClickSearchResult(String url, String name, String imgUrl) {
    print(url);
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => RecipeScreen(url:url, name:name, imgUrl: imgUrl))
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text(
                'Search For Recipe',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 55),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: _buildTextComposer(),
              ),
              SizedBox(
                height: 20,
              ),
              Flexible(
                child:  _searched ? _shownRecipes.length > 0
                    ? ListView.builder(
                  itemCount: _shownRecipes.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      _handleClickSearchResult(_shownRecipes[index].url,
                          _shownRecipes[index].name,
                          _shownRecipes[index].imageUrl);
                    },
                    child: Card(
                      key: ValueKey(index),
                      color: Colors.white,
                      elevation: 4,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child:Padding(
                        padding: EdgeInsets.all(25.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 22,
                              child: Image.network(
                                  DotEnv.env['CORS_PROXY'] + DotEnv.env['THUMBNAIL'] + _shownRecipes[index].imageUrl,
                                  headers: {'X-Requested-With':'XMLHttpRequest'},
                                  fit: BoxFit.cover),
                            ),
                            SizedBox(width: 50),
                            Expanded(
                              flex: 78,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(_shownRecipes[index].name,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                  SizedBox(height: 15),
                                  Text(_shownRecipes[index].description,
                                      style: TextStyle(fontSize: 16)),
                                  SizedBox(height: 10),
                                  Text(_shownRecipes[index].ingredientsPreview,
                                      style: Theme.of(context).textTheme.bodyText1)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                    : Text(
                  'No results found',
                  style: TextStyle(fontSize: 24),
                ):SizedBox(width: 10),
              ),
      ])),
    );
  }
}
