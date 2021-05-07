import 'package:flutter/material.dart';
import '../screens/stats.dart';
import '../constants/colors.dart';
import 'details.dart';
import 'package:projeto_tfc/models/event.dart';
import 'eventstoapprove.dart';
import '../services/api.dart';
import 'login.dart';
import 'memberstoapprove.dart';
import '../providers/plafond.dart';
import 'package:provider/provider.dart';

Api _api = Api();

List<Event> _events = _api.events;

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
        body: new LayoutBuilder(
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
                            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                            itemCount: _events.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return new GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailsScreen(_events[index], index),
                                        ));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(15,15,15,0),
                                    height: 200,
                                    child: DateTime.parse(_events[index].deadline).isAfter(DateTime.now()) ? Card(
                                      elevation: 7,
                                      child: Row(
                                        children: [
                                          image(_events[index], context),
                                          event(_events[index], context)
                                        ],
                                      ),
                                    ) : Card(
                                      color: Colors.grey.shade200,
                                      elevation: 7,
                                      child: Row(
                                        children: [
                                          ColorFiltered(
                                            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
                                            child: image(_events[index], context),
                                          ),
                                          event(_events[index], context),
                                        ],
                                      ),
                                    ),
                                  ),
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

Widget event(Event event, context) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: RichText(
      text: TextSpan(
        text: '${event.name}',
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: (20 / 720) * MediaQuery.of(context).size.height,
        ),
        children: <TextSpan>[
          TextSpan(text: '\n${event.date}', style: TextStyle(color: Colors.grey, fontSize: (15 / 720) * MediaQuery.of(context).size.height)),
        ],
      ),
    ),
  );
}

Widget image(Event event, context) {
  if(event.image!=null){
    return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 5.0, top: 10.0, bottom: 10.0),
        child: Image(image: AssetImage('${event.image}'), width: MediaQuery.of(context).size.width/4,
          height: 150,)
    );
  }
  return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(width: 100, height: 150)
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

class EventsItemsSearch extends SearchDelegate<Event>{

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
    final mylist = query.isEmpty ? _events : _events.where((p) => p.name.toString().startsWith(query)).toList();
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
                      builder: (context) => DetailsScreen(mylist[index], index),
                    ));
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(15,15,15,0),
                height: 200,
                child: Card(
                  elevation: 7,
                  child: Row(
                    children: [
                      image(mylist[index], context),
                      event(mylist[index], context)
                    ],
                  ),
                ),
              )
          );
        });
  }

}