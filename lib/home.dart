import 'package:flutter/material.dart';
import 'package:projeto_tfc/stats.dart';
import 'colors.dart';
import 'details.dart';
import 'eventstoapprove.dart';
import 'listevents.dart';
import 'login.dart';
import 'memberstoapprove.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen>{

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
            TextSpan(text: '\n${list['date']}', style: TextStyle(color: Colors.grey, fontSize: 15,)),
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
              onPressed: (){
              }
          )
        ],
      ),
      body: ListView.builder(
          itemCount: Events.getEvents.length, // the length
          itemBuilder: (context, index) {
            return new GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(Events.getEvents[index].toString()),
                      ));
                },
                child: Container(
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
                )

            );
          }),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(
                  color: Color().primaryColor,
                ),
                child: Container(
                  child: Column(
                      children: <Widget>[
                        Material(
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                            child: Icon(Icons.person, color: Colors.blueGrey, size: 80)
                        ),
                        Padding(padding: EdgeInsets.all(15.0),
                          child: Text(
                            'John Doe',
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EventsListScreen()),
                );
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MembersListScreen()),
                );
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StatsScreen()),
                );
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
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                    LoginScreen()), (Route<dynamic> route) => false
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}