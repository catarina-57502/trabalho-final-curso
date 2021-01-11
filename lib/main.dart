import 'package:flutter/material.dart';
import 'events.dart';

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

  Widget event(list) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: RichText(
        text: TextSpan(
          text: '${list['name']}',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20
          ),
          children: <TextSpan>[
            TextSpan(text: '\n${list['local']}', style: TextStyle(color: Colors.grey, fontSize: 15,)),
          ],
        ),
      ),
    );
  }

  Widget image(list) {
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Image(image: AssetImage('${list['image']}'), width: 100,
          height: 150,)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: null
          )
        ],
      ),
      body: ListView.builder(
          itemCount: Events.getEvents.length, // the length
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.fromLTRB(15,15,15,0),
              height: 200,
              child: Card(
                elevation: 7,
                child: Row(
                  children: [
                    image(Events.getEvents[index]),
                    event(Events.getEvents[index])
                  ],
                ),
              ),
            );
          }),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.cyan,
                ),
                child: Container(
                  child: Column(
                      children: <Widget>[
                        Material(
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                            child: Icon(Icons.person, color: Colors.blueGrey, size: 80)
                        ),
                        Padding(padding: EdgeInsets.all(15.0), child:
                        Text('José António',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        )
                      ]
                  ),

                )
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text(
                'Home',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.event),
              title: Text(
                'Events List',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text(
                'Members List',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.bar_chart),
              title: Text(
                'Statistics',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
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