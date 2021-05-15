import 'package:flutter/material.dart';
import 'recipe.dart';
import 'welcome.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;


void main() {
  DotEnv.load();
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
    {"id": 1, "name": "芝麻薄脆餅乾", "age": 29, "ingredients":"食材：低筋麵粉、熟白芝麻、蛋白兩顆、鹽少許、細白砂糖、植物油、香草精（可不加）", "img":"https://imageproxy.icook.network/resize?background=255%2C255%2C255&height=150&nocrop=false&stripmeta=true&type=auto&url=http%3A%2F%2Ftokyo-kitchen.icook.tw.s3.amazonaws.com%2Fuploads%2Frecipe%2Fcover%2F373754%2F9231b8fc9d4306c8.jpg&width=200"},
    {"id": 2, "name": "可愛的「小熊白色戀人餅乾」內餡香濃好滋味", "age": 40, "ingredients":"食材：金桶牛油、糖粉、玉米粉、低筋麵粉", "img":"https://imageproxy.icook.network/resize?background=255%2C255%2C255&height=150&nocrop=false&stripmeta=true&type=auto&url=http%3A%2F%2Ftokyo-kitchen.icook.tw.s3.amazonaws.com%2Fuploads%2Frecipe%2Fcover%2F373627%2F63cf385d08778d22.jpg&width=200"},
    {"id": 3, "name": "曲奇餅乾", "age": 5, "ingredients":"食材：蓬萊米粉、高筋麵粉、糖、鹽、泡打粉、速發乾燥酵母、豆漿、奶油", "img":"https://imageproxy.icook.network/resize?background=255%2C255%2C255&height=150&nocrop=false&stripmeta=true&type=auto&url=http%3A%2F%2Ftokyo-kitchen.icook.tw.s3.amazonaws.com%2Fuploads%2Frecipe%2Fcover%2F373452%2Fecc197c968e77c1b.jpg&width=200"},
    {"id": 4, "name": "天使餅乾：米粉豆漿酵母司康", "age": 35, "ingredients":"食材：(1)低筋麵粉、(2)無鋁泡打粉、(3)椰漿粉、(4)食用小蘇打粉、(5)糖粉、(6)海鹽、鮮奶、清淡橄欖油、熟黑芝麻粒、花型餅乾模", "img":"https://imageproxy.icook.network/resize?background=255%2C255%2C255&height=150&nocrop=false&stripmeta=true&type=auto&url=http%3A%2F%2Ftokyo-kitchen.icook.tw.s3.amazonaws.com%2Fuploads%2Frecipe%2Fcover%2F371488%2Ffe778ca38dd4dd21.jpg&width=200"},
    {"id": 5, "name": "黑芝麻小花餅乾", "age": 21, "ingredients":"食材：巧克力、無鹽奶油、糖粉、雞蛋液、低筋麵粉、鹽", "img":"https://imageproxy.icook.network/resize?background=255%2C255%2C255&height=150&nocrop=false&stripmeta=true&type=auto&url=http%3A%2F%2Ftokyo-kitchen.icook.tw.s3.amazonaws.com%2Fuploads%2Frecipe%2Fcover%2F373055%2F20bc17d5f1c8dcd5.jpg&width=200"},
    {"id": 6, "name": "好夢幻「戒指餅乾」好玩又好吃♡", "age": 55, "ingredients":"食材：蛋白、糖、蛋黃、糖粉、低筋麵粉", "img":"https://imageproxy.icook.network/resize?background=255%2C255%2C255&height=150&nocrop=false&stripmeta=true&type=auto&url=http%3A%2F%2Ftokyo-kitchen.icook.tw.s3.amazonaws.com%2Fuploads%2Frecipe%2Fcover%2F373033%2F33e725f1fd56d0d9.jpg&width=200"},
    {"id": 7, "name": "簡單的手指餅乾", "age": 30, "ingredients":"食材：低筋麵粉、無鹽奶油、糖、鹽、蛋、玫瑰奶茶茶包", "img":"https://imageproxy.icook.network/resize?background=255%2C255%2C255&height=150&nocrop=false&stripmeta=true&type=auto&url=http%3A%2F%2Ftokyo-kitchen.icook.tw.s3.amazonaws.com%2Fuploads%2Frecipe%2Fcover%2F372971%2Fd84ab466fd99ec22.jpg&width=200"},
    {"id": 8, "name": "玫瑰奶茶餅乾（３點一刻茶包）", "age": 14, "ingredients":"食材：奶油、細砂糖、全蛋、低筋麵粉、果醬", "img":"https://imageproxy.icook.network/resize?background=255%2C255%2C255&height=150&nocrop=false&stripmeta=true&type=auto&url=http%3A%2F%2Ftokyo-kitchen.icook.tw.s3.amazonaws.com%2Fuploads%2Frecipe%2Fcover%2F372905%2F693899289ec09c09.jpg&width=200"},
    {"id": 9, "name": "林茲餅乾", "age": 100, "ingredients":"食材：低筋麵粉、無鹽奶油、抹茶粉、糖粉、可可粉、鹽、全蛋", "img":"https://imageproxy.icook.network/resize?background=255%2C255%2C255&height=150&nocrop=false&stripmeta=true&type=auto&url=http%3A%2F%2Ftokyo-kitchen.icook.tw.s3.amazonaws.com%2Fuploads%2Frecipe%2Fcover%2F372446%2F908fcbfc4588b161.jpg&width=200"},
    {"id": 10, "name": "手工餅乾🍪原味、抹茶、可可", "age": 32, "ingredients":"食材：低筋麵粉、三合一咖啡粉、蛋、無鹽奶油、（二）砂糖、敲碎的堅果", "img":"https://imageproxy.icook.network/resize?background=255%2C255%2C255&height=150&nocrop=false&stripmeta=true&type=auto&url=http%3A%2F%2Ftokyo-kitchen.icook.tw.s3.amazonaws.com%2Fuploads%2Frecipe%2Fcover%2F372302%2F4b5e3f564331caa7.jpg&width=200"},
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
                      leading: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 128,
                          minHeight: 128,
                          maxWidth: 256,
                          maxHeight: 256,
                        ),
                        child: Image.network("https://api.allorigins.win/raw?url="+Uri.encodeComponent(_foundUsers[index]['img'])),
                      ),
                      title: Text(_foundUsers[index]['name']),
                      subtitle: Text(
                          '${_foundUsers[index]["ingredients"]}'),
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
