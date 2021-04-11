import 'package:flutter/material.dart';
import 'colors.dart';
import 'listeventstoapprove.dart';
import 'login.dart';

class EventsListScreen extends StatefulWidget {
  EventsListScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState(){
    return _EventsListScreenState();
  }

}


class _EventsListScreenState extends State<EventsListScreen>{

  Widget eventToApprove(list) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: RichText(
        text: TextSpan(
          text: '${list['name']}',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20
          ),
          children: <TextSpan>[
            TextSpan(text: '\n${list['date']}', style: TextStyle(color: Colors.grey, fontSize: 15)),
            TextSpan(text: '\n${list['deadline']}', style: TextStyle(color: Colors.grey, fontSize: 15)),
            TextSpan(text: '\n${list['local']}', style: TextStyle(color: Colors.grey, fontSize: 15)),
            TextSpan(text: '\n${list['type']}', style: TextStyle(color: Colors.grey, fontSize: 15)),
            TextSpan(text: '\n${list['cost']}', style: TextStyle(color: Colors.grey, fontSize: 15)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Events List'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: null
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
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(15.0),
                        height: 55.0,
                        decoration: BoxDecoration(
                            border: Border.all(color: Color().plafond),
                        ),
                        child: Text(
                          'Plafond: $plafond€',
                          style: TextStyle(fontSize: 20.0, color: Colors.orange, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 10),
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: EventsToAprrove.getEvents.length, // the length
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
                                      child: eventToApprove(EventsToAprrove.getEvents[index]),
                                    ),
                                    ButtonBar(
                                      alignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        RaisedButton(
                                          onPressed: (){

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
}