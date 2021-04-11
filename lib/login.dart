import 'package:flutter/material.dart';

import 'colors.dart';
import 'home.dart';
import 'listusers.dart';

int plafond = 0;

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState(){
    return _LoginScreenState();
  }

}

class _LoginScreenState extends State<LoginScreen>{

  String _username;
  String _password;
  final _formKey = GlobalKey<FormState>();

  void getPlafond(name, pass) {
    setState(() {
      for(var i in Users.getUsers){
        if('${i['username']}'== name && '${i['password']}'== pass){
          plafond = i['plafond'];
        }
      }
    });
  }

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
                                      getPlafond(_username, _password);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => HomeScreen('Sistema de Gestão de Eventos', getName(_username, _password), getRole(_username, _password))),
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
}

bool isCredentialsCorrect(name, pass) {

  for(var i in Users.getUsers){
    if('${i['username']}'== name && '${i['password']}'== pass){
      return true;
    }
  }
  return false;
}

String getName(name, pass) {

  for(var i in Users.getUsers){
    if('${i['username']}'== name && '${i['password']}'== pass){
      return '${i['name']}';
    }
  }
}

String getRole(name, pass) {

  for(var i in Users.getUsers){
    if('${i['username']}'== name && '${i['password']}'== pass){
      return '${i['role']}';
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