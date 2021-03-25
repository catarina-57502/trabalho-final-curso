import 'package:flutter/material.dart';

import 'listmembertoapprove.dart';

class MembersListScreen extends StatefulWidget {
  MembersListScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState(){
    return _MembersListScreenState();
  }

}

class _MembersListScreenState extends State<MembersListScreen>{

  Widget memberToApprove(list) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: RichText(
        text: TextSpan(
          text: '${list['name']}',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20
          ),
          children: <TextSpan>[
            TextSpan(text: '\n${list['CC']}', style: TextStyle(color: Colors.grey, fontSize: 15)),
            TextSpan(text: '\n${list['office']}', style: TextStyle(color: Colors.grey, fontSize: 15)),
            TextSpan(text: '\n${list['reg']}', style: TextStyle(color: Colors.grey, fontSize: 15)),
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
        title: Text('Members List'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: null
          )
        ],
      ),
      body: ListView.builder(
          itemCount: MembersToAprrove.getMember.length, // the length
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.fromLTRB(15,15,15,0),
              height: 200,
              child: Card(
                elevation: 7,
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: memberToApprove(MembersToAprrove.getMember[index]),
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
    );
  }
}