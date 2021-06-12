import 'package:flutter/material.dart';
import 'package:projeto_tfc/models/event.dart';
import 'package:projeto_tfc/services/api.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../providers/plafond.dart';

Api _api = Api();

List<Event> _eventsApprove = _api.eventsApprove;

class EventsListScreen extends StatefulWidget {
  EventsListScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState(){
    return _EventsListScreenState();
  }

}

class _EventsListScreenState extends State<EventsListScreen>{


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
                      ListView.builder(
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
                          }),
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
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = RaisedButton(
        child: Text("Approve"),
        color: Colors.green,
        onPressed:  () {
          setState(() {
            _api.events.add(_eventsApprove[index]);
            _eventsApprove.remove(_eventsApprove[index]);
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
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = RaisedButton(
        child: Text("Dismiss"),
        color: Colors.red,
        onPressed:  () {
          setState(() {
            _eventsApprove.remove(_eventsApprove[index]);
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
          TextSpan(text: '\nDeadline: ${event.deadline}', style: TextStyle(color: Colors.grey, fontSize: 15)),
          TextSpan(text: '\nLocal: ${event.local}', style: TextStyle(color: Colors.grey, fontSize: 15)),
          TextSpan(text: '\nType: ${event.type}', style: TextStyle(color: Colors.grey, fontSize: 15)),
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
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = RaisedButton(
        child: Text("Approve"),
        color: Colors.green,
        onPressed:  () {
          _api.events.add(_eventsApprove[index]);
          _eventsApprove.remove(_eventsApprove[index]);
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
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = RaisedButton(
        child: Text("Dismiss"),
        color: Colors.red,
        onPressed:  () {
          _eventsApprove.remove(_eventsApprove[index]);
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