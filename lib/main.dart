import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema de Gestão de Eventos',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
          primaryTextTheme: TextTheme(
              headline6: TextStyle(
                  color: Colors.white
              )
          )
      ),
      //home: LoginScreen(),
      home: HomeScreen(title: 'Sistema de Gestão de Eventos'),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState(){
    return _HomeScreenState();
  }

}

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState(){
    return _LoginScreenState();
  }

}

class _HomeScreenState extends State<HomeScreen>{

  int _contador = 0;

  TextEditingController _controller;

  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildList() => ListView(
    children: [
      _tile('Corrida 25 de Abril', 'Lisboa', 'assets/images/25abril.jpg'),
      Divider(),
      _tile('Maratona EDP', 'Lisboa', 'assets/images/edp.jpg'),
      Divider(),
      _tile('São Silvestre Amadora', 'Amadora', 'assets/images/saosilvestre.jpg'),
      Divider(),
    ],
  );

  ListTile _tile(String title, String subtitle, String image) => ListTile(
    title: Text(title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        )),
    subtitle: Text(subtitle),
    leading: Image.asset(image),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: null
          )
        ],
      ),
      body: Container(
        child:
        Stack(
          children: <Widget>[
            _buildList()
          ],
        ),
      ),
    );
  }
}

class _LoginScreenState extends State<LoginScreen>{

  TextEditingController _controller;

  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
          alignment: Alignment.topCenter,
          child:
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: 'Sistema de Gestão', style: TextStyle(color: Colors.grey[850], height: 5, fontSize: 31, fontFamily: 'Arial')),
                TextSpan(text: '\n       de Eventos', style: TextStyle(color: Colors.grey[850], height: 0.5, fontSize: 31, fontFamily: 'Arial'))
              ],
            ),
          )
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.center,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              )
          )
        ],
      ),
    );
  }
}