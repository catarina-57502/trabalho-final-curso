import 'package:flutter/material.dart';
import 'package:projeto_tfc/models/event.dart';
import 'package:projeto_tfc/screens/home.dart';
import 'package:projeto_tfc/services/api.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../providers/plafond.dart';

Api _api = Api();

List<Event> _eventsApprove = [];

class EventsListScreen extends StatefulWidget {
  EventsListScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState(){
    return _EventsListScreenState();
  }

}

class _EventsListScreenState extends State<EventsListScreen>{

  Future<List<Event>> futureEventsApprove;

  @override
  void initState() {
    super.initState();
    futureEventsApprove = fetchEvents();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Approve Events'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: (){
                showSearch(context: context, delegate: EventsApproveItemsSearch());
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
                    children: [
                      SizedBox(height: 10),
                      FutureBuilder<List<Event>>(
                          future: futureEventsApprove,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              _eventsApprove.clear();
                              for (Event i in snapshot.data) {
                                if (i.approvedP == null) { //quando é false mas imprime null nao sei bem porquê
                                  _eventsApprove.add(i);
                                }
                            }
                              return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: _eventsApprove.length, // the length
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: EdgeInsets.fromLTRB(15,15,15,0),
                                      height: 240,
                                      child: Card(
                                        elevation: 7,
                                        child: Column(
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: eventToApprove(_eventsApprove[index]),
                                            ),
                                            ButtonBar(
                                              alignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                RaisedButton(
                                                  onPressed: (){
                                                    showAlertDialogApprove(context, _eventsApprove[index], index);
                                                  },
                                                  color: Colors.green,
                                                  child: Text (
                                                    'Approve',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20
                                                    ),
                                                  ),
                                                ),

                                                RaisedButton(
                                                  onPressed: (){
                                                    showAlertDialogDismiss(context, _eventsApprove[index], index);
                                                  },
                                                  color: Colors.red,
                                                  child: Text (
                                                    'Dismiss',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            }else if(snapshot.hasError){
                              print("${snapshot.error}");
                              return Container(
                                height: MediaQuery.of(context).size.width,
                                alignment: Alignment.center,
                                child:Text(
                                  'No Events to Approve',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 22, color: Colors.orange, fontWeight: FontWeight.bold),
                                ),
                              );
                            }
                            return CircularProgressIndicator();
                          }
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
      ),
    );
  }

  void showAlertDialogApprove(BuildContext context, Event event, int index) {
    Widget cancelButton = FlatButton(
      child: Text("Cancel", style: TextStyle(
        color: Color().primaryColor,
      )),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = RaisedButton(
        child: Text("Approve", style: TextStyle(
          color: Colors.white,
        )),
        color: Colors.green,
        onPressed:  () {
          setState(() {
            updateEvent(event.id, true);
            futureEventsApprove = fetchEvents();
          });
          Navigator.pop(context);
        }
    );


    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(event.name),
      content: Text("Are you sure you want to approve this event?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showAlertDialogDismiss(BuildContext context, Event event, int index) {
    Widget cancelButton = FlatButton(
      child: Text("Cancel", style: TextStyle(
        color: Color().primaryColor,
      )),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = RaisedButton(
        child: Text("Dismiss", style: TextStyle(
          color: Colors.white,
        )),
        color: Colors.red,
        onPressed:  () {
          setState(() {
            updateEvent(event.id, false);
            futureEventsApprove = fetchEvents();
          });
          Navigator.pop(context);
        }
    );


    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(event.name),
      content: Text("Are you sure you want to dismiss this event?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}

Widget eventToApprove(Event event) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: RichText(
      text: TextSpan(
        text: '${event.name}',
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20
        ),
        children: <TextSpan>[
          TextSpan(text: '\nDate: ${event.date}', style: TextStyle(color: Colors.grey, fontSize: 15)),
          TextSpan(text: '\nDeadline: ${event.dueDate}', style: TextStyle(color: Colors.grey, fontSize: 15)),
          TextSpan(text: '\nLocal: ${event.location}', style: TextStyle(color: Colors.grey, fontSize: 15)),
          TextSpan(text: '\nType: ${event.activities}', style: TextStyle(color: Colors.grey, fontSize: 15)),
          TextSpan(text: '\nCost: ${event.cost}€', style: TextStyle(color: Colors.grey, fontSize: 15)),
        ],
      ),
    ),
  );
}

class EventsApproveItemsSearch extends SearchDelegate<Event>{

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
    final mylist = query.isEmpty ? _eventsApprove : _eventsApprove.where((p) => p.name.toString().startsWith(query)).toList();
    return mylist.isEmpty ? Text('No results found...', style: TextStyle(fontSize: 20)) : ListView.builder(
        itemCount: mylist.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.fromLTRB(15,15,15,0),
            height: 240,
            child: Card(
              elevation: 7,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: eventToApprove(mylist[index]),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: (){
                          showAlertDialogApprove(context, mylist[index], index);
                        },
                        color: Colors.green,
                        child: Text (
                          'Approve',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                          ),
                        ),
                      ),

                      RaisedButton(
                        onPressed: (){
                          showAlertDialogDismiss(context, mylist[index], index);
                        },
                        color: Colors.red,
                        child: Text (
                          'Dismiss',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  void showAlertDialogApprove(BuildContext context, Event event, int index) {
    Widget cancelButton = FlatButton(
      child: Text("Cancel", style: TextStyle(
        color: Color().primaryColor,
      )),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = RaisedButton(
        child: Text("Approve", style: TextStyle(
        color: Colors.white,
        )),
        color: Colors.green,
        onPressed:  () {
          Navigator.pop(context);
          Navigator.pop(context);
        }
    );


    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(event.name),
      content: Text("Are you sure you want to approve this event?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showAlertDialogDismiss(BuildContext context, Event event, int index) {
    Widget cancelButton = FlatButton(
      child: Text("Cancel", style: TextStyle(
        color: Color().primaryColor,
      )),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = RaisedButton(
        child: Text("Dismiss", style: TextStyle(
          color: Colors.white,
        )),
        color: Colors.red,
        onPressed:  () {
          Navigator.pop(context);
          Navigator.pop(context);
        }
    );


    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(event.name),
      content: Text("Are you sure you want to dismiss this event?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}