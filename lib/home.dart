import 'package:flutter/material.dart';
import 'package:projeto_tfc/stats.dart';
import 'colors.dart';
import 'details.dart';
import 'eventstoapprove.dart';
import 'listevents.dart';
import 'login.dart';
import 'memberstoapprove.dart';
import 'plafond.dart';
import 'package:provider/provider.dart';

List<bool> listEventsReg = List.filled(Events.getEvents.length, false);

class HomeScreen extends StatefulWidget {
  final String title;
  final String name;
  final String role;

  HomeScreen(this.title, this.name, this.role);

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen>{

  @override
  Widget build(BuildContext context) {
    final plafond = Provider.of<Plafond>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search, color: Colors.white),
                onPressed: (){
                  showSearch(context: context, delegate: EventsItemsSearch());
                }
            )
          ],
        ),
        body:new LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Container(
                  child: Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(15.0),
                          height: 55.0,
                          decoration: BoxDecoration(
                              border: Border.all(color: Color().plafond)
                          ),
                          child: Consumer<Plafond>(
                            builder: (context, plafond, child) => Text(
                              'Plafond: ${plafond.value}€',
                              style: TextStyle(fontSize: 20.0, color: Colors.orange, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        ListView.builder(
                            itemCount: Events.getEvents.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return new GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailsScreen(Events.getEvents[index].toString(), index),
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
                      ]
                  ),
                ),
              ),
            );
          },
        ),
        drawer: roleMenu(context, widget.name, widget.role),
    );
  }
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

Widget roleMenu(context, name, role){
  final plafond = Provider.of<Plafond>(context, listen: false);

  if(role == "Administrator"){
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 225.0,
            child: DrawerHeader(
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
                        Padding(padding: EdgeInsets.all(10.0),
                          child: Column(
                              children: <Widget>[
                                Text(
                                  name,
                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  role,
                                  style: TextStyle(color: Colors.white, fontSize: 12),
                                ),
                                SizedBox(height: 10),
                                Consumer<Plafond>(
                                  builder: (context, plafond, child) => Text(
                                    'Plafond: ${plafond.value}€',
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                )

                              ]
                          ),
                        )
                      ]
                  ),

                )
            ),
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
              'Approve Events',
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
              'Approve Members',
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
    );
  }else{
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 225.0,
            child: DrawerHeader(
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
                        Padding(padding: EdgeInsets.all(10.0),
                          child: Column(
                              children: <Widget>[
                                Text(
                                  name,
                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  role,
                                  style: TextStyle(color: Colors.white, fontSize: 12),
                                ),
                                SizedBox(height: 10),
                                Consumer<Plafond>(
                                  builder: (context, plafond, child) => Text(
                                    'Plafond: ${plafond.value}€',
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                )
                              ]
                          ),
                        )
                      ]
                  ),
                )
            ),
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
    );
  }
}

class EventsItemsSearch extends SearchDelegate<Events>{
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed:(){
      query = "";
    })];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(onPressed:(){
      close(context, null);
    }, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final mylist = query.isEmpty ? Events.getEvents : Events.getEvents.where((p) => p['name'].toString().startsWith(query)).toList();
    return mylist.isEmpty ? Text('No results found...', style: TextStyle(fontSize: 20)) : ListView.builder(
        itemCount: mylist.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return new GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(mylist[index].toString(), index),
                    ));
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(15,15,15,0),
                height: 200,
                child: Card(
                  elevation: 7,
                  child: Row(
                    children: [
                      image(mylist[index]),
                      event(mylist[index])
                    ],
                  ),
                ),
              )
          );
        });
  }

}