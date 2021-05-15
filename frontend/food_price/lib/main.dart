import 'package:flutter/material.dart';
import 'recipe.dart';
import 'welcome.dart';

void main() {
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
        primarySwatch: Colors.orange,
      ),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        '/': (context) => MyHomePage(title: 'Recipe Link'),
        '/welcome': (context) => WelcomeScreen(),
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
  int _counter = 0;
  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundUsers = [];

  final List<Map<String, dynamic>> _allUsers = [
    {"id": 1, "name": "Andy", "age": 29},
    {"id": 2, "name": "Aragon", "age": 40},
    {"id": 3, "name": "Bob", "age": 5},
    {"id": 4, "name": "Barbara", "age": 35},
    {"id": 5, "name": "Candy", "age": 21},
    {"id": 6, "name": "Colin", "age": 55},
    {"id": 7, "name": "Audra", "age": 30},
    {"id": 8, "name": "Banana", "age": 14},
    {"id": 9, "name": "Caversky", "age": 100},
    {"id": 10, "name": "Becky", "age": 32},
  ];

  final _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isComposing = false;

  @override
  initState() {
    // at the beginning, all users are shown
    _foundUsers = _allUsers;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
          user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  void _handleSubmitted(String text) {
    Navigator.of(context).pushNamed('/welcome');
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
                  onSubmitted: _isComposing ? _handleSubmitted : null,
                  decoration:
                  InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 10),
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
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Search For Recipe!!',
                style: Theme.of(context).textTheme.headline2 ,
              ),
              Container(
                child: _buildTextComposer(),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: _foundUsers.length > 0
                    ? ListView.builder(
                  itemCount: _foundUsers.length,
                  itemBuilder: (context, index) => Card(
                    key: ValueKey(_foundUsers[index]["id"]),
                    color: Colors.amberAccent,
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      leading: Text(
                        _foundUsers[index]["id"].toString(),
                        style: TextStyle(fontSize: 24),
                      ),
                      title: Text(_foundUsers[index]['name']),
                      subtitle: Text(
                          '${_foundUsers[index]["age"].toString()} years old'),
                    ),
                  ),
                )
                    : Text(
                  'No results found',
                  style: TextStyle(fontSize: 24),
                ),
              ),
      ]),
      ),
    );
  }
}
