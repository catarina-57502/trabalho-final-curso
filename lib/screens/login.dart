import 'dart:core';
import 'package:flutter/material.dart';
import 'package:projeto_tfc/models/user.dart';
import 'package:projeto_tfc/services/api.dart';
import '../providers/plafond.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import 'home.dart';
import 'dart:async';

Api _api = Api();

String nameAuth;
String roleAuth;

List<User> _users = _api.usersAuth;

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState(){
    return _LoginScreenState();
  }

}

class _LoginScreenState extends State<LoginScreen>{

  Future<User> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = fetchUsers();
  }


  String _username;
  String _password;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: new LayoutBuilder(
            builder: (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(24),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: 'Sign In', style: TextStyle(color: Colors.grey[850], height: 5, fontSize: 40, fontFamily: 'Arial')),
                                  ],
                                ),
                              ),
                              /*
                              FutureBuilder<User>(
                                future: futureUsers,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    print(snapshot.data.id.toString());
                                  } else if (snapshot.hasError) {
                                    print("${snapshot.error}");
                                  }
                                },
                              ),
                               */
                              SizedBox(height: 30),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    'Username',
                                    style: TextStyle(
                                      color: Color().primaryColor,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  contentPadding: new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0)
                                  ),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Color().primaryColor,
                                  ),
                                  hintText: 'Enter Username',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Required field';
                                  }
                                  return null;
                                },
                                onSaved: (value) => _username = value,
                              ),
                              SizedBox(height: 30),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    'Password',
                                    style: TextStyle(
                                      color: Color().primaryColor,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  contentPadding: new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0)
                                  ),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Color().primaryColor,
                                  ),
                                  hintText: '**********',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Required field';
                                  }
                                  return null;
                                },
                                onSaved: (value) => _password = value,
                              ),
                              SizedBox(height: 60),
                              ButtonTheme(
                                minWidth: 380,
                                child: RaisedButton(
                                  color: Color().primaryColor,
                                  onPressed: (){
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      if(isCredentialsCorrect(_username, _password)){
                                        getPlafond(_username, _password, context);
                                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                            HomeScreen('Sistema de Gestão de Eventos', getName(_username, _password), getRole(_username, _password))), (Route<dynamic> route) => false
                                        );
                                      }else{
                                        showAlertDialog(context);
                                      }
                                    }
                                  },
                                  padding: EdgeInsets.all(15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    'LOGIN',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
        ),
    );
  }

  void getPlafond(name, pass, context) {
    final plafond = Provider.of<Plafond>(context, listen: false);
    for(var i in _users){
      if('${i.username}'== name /*&& '${i.password}'== pass*/){
        plafond.setPlafond(i.plafond);
      }
    }
  }

  bool isCredentialsCorrect(name, pass) {
    for(var i in _users){
      if('${i.username}'== name /*&& '${i.password}'== pass*/){
        return true;
      }
    }
    return false;
  }

  String getName(name, pass) {

    for(var i in _users){
      if('${i.username}'== name/*&& '${i.password}'== pass*/){
        nameAuth = i.name;
        return '${i.name}';
      }
    }
  }

  String getRole(name, pass) {

    for(var i in _users){
      if('${i.username}'== name /*&& '${i.password}'== pass*/){
        if(i.adminP){
          roleAuth = 'Administrator';
        }else{
          roleAuth = 'Member';
        }
        return roleAuth;
      }
    }
  }

}



void showAlertDialog(BuildContext context) {

  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text('Sistema de Gestão de Eventos'),
    content: Text('Username or password incorrect'),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}