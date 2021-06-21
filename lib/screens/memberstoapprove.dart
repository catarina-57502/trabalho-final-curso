import 'package:flutter/material.dart';
import 'package:projeto_tfc/models/user.dart';
import 'package:projeto_tfc/services/api.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../providers/plafond.dart';

Plafond _plafond = Plafond();

Api _api = Api();

List<User> _usersApprove = [];

class MembersListScreen extends StatefulWidget {
  MembersListScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState(){
    return _MembersListScreenState();
  }

}

class _MembersListScreenState extends State<MembersListScreen>{

  Future<List<User>> futureUsersApprove;

  @override
  void initState() {
    super.initState();
    futureUsersApprove = fetchUsers();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Approve Members'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: (){
                showSearch(context: context, delegate: MembersApproveItemsSearch());
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
                      FutureBuilder<List<User>>(
                          future: futureUsersApprove,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              _usersApprove.clear();
                              for (User i in snapshot.data) {
                                if (i.approvedP == null) { //quando é false mas imprime null nao sei bem porquê
                                  _usersApprove.add(i);
                                }
                              }
                              return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: _usersApprove.length, // the length
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
                                              child: memberToApprove(_usersApprove[index]),
                                            ),
                                            ButtonBar(
                                              alignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                RaisedButton(
                                                  onPressed: (){
                                                    showAlertDialogApprove(context, _usersApprove[index], index);
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
                                                    showAlertDialogDismiss(context, _usersApprove[index], index);
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
                                  'No Users to Approve',
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

  void showAlertDialogApprove(BuildContext context, User user, int index) {
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
            _api.usersAuth.add(_usersApprove[index]);
            _usersApprove.remove(_usersApprove[index]);
          });
          Navigator.pop(context);
        }
    );


    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(user.name),
      content: Text("Are you sure you want to approve this member?"),
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

  void showAlertDialogDismiss(BuildContext context, User user, int index) {
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
            _usersApprove.remove(_usersApprove[index]);
          });
          Navigator.pop(context);
        }
    );


    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(user.name),
      content: Text("Are you sure you want to dismiss this member?"),
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

Widget memberToApprove(User user) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: RichText(
      text: TextSpan(
        text: '${user.name}',
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20
        ),
        children: <TextSpan>[
          TextSpan(text: '\nCC: ${user.cc}', style: TextStyle(color: Colors.grey, fontSize: 15)),
          TextSpan(text: '\nOffice: ${user.office}', style: TextStyle(color: Colors.grey, fontSize: 15)),
          TextSpan(text: '\nBirthdate: ${user.birthdate}', style: TextStyle(color: Colors.grey, fontSize: 15)),
          TextSpan(text: '\nE-mail: ${user.email}', style: TextStyle(color: Colors.grey, fontSize: 15)),
          TextSpan(text: '\nT-shirt: ${user.tshirt}', style: TextStyle(color: Colors.grey, fontSize: 15)),
        ],
      ),
    ),
  );
}

class MembersApproveItemsSearch extends SearchDelegate<User>{

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
    final mylist = query.isEmpty ? _usersApprove : _usersApprove.where((p) => p.name.toString().startsWith(query)).toList();
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
                    child: memberToApprove(mylist[index]),
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

  void showAlertDialogApprove(BuildContext context, User user, int index) {
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
          _api.usersAuth.add(_usersApprove[index]);
          _usersApprove.remove(_usersApprove[index]);
          Navigator.pop(context);
          Navigator.pop(context);
        }
    );


    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(user.name),
      content: Text("Are you sure you want to approve this member?"),
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

  void showAlertDialogDismiss(BuildContext context, User user, int index) {
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
          _usersApprove.remove(_usersApprove[index]);
          Navigator.pop(context);
          Navigator.pop(context);
        }
    );


    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(user.name),
      content: Text("Are you sure you want to dismiss this member?"),
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