import 'package:flutter/material.dart';
import 'colors.dart';

class DetailsScreen extends StatefulWidget {

  final event;

  DetailsScreen(this.event);

  @override
  State<StatefulWidget> createState(){
    return _DetailsScreenState(event);
  }

}

class _DetailsScreenState extends State<DetailsScreen>{

  final String event;

  _DetailsScreenState(this.event);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          titulo(event),
        ),
      ),
      body: new LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Container(
                  margin: const EdgeInsets.all(20.0),
                  child: Column(
                      children: <Widget>[
                        Center(
                          child: Image(image: AssetImage(imagem(event)), width: 200,
                            height: 150,),
                        ),
                        SizedBox(height: 50),
                        Text(
                            'Date: ' + data(event)
                        ),
                        SizedBox(height: 20),
                        Text(
                            'Deadline: ' + prazo(event)
                        ),
                        SizedBox(height: 20),
                        Text(
                            'Local: ' + local(event)
                        ),
                        SizedBox(height: 20),
                        Text(
                            'Type: ' + tipo(event)
                        ),
                        SizedBox(height: 20),
                        Text(
                            'Cost: ' + custo(event)
                        ),
                        SizedBox(height: 50),
                        ButtonTheme(
                          minWidth: 380.0,
                          height: 55.0,
                          child: RaisedButton(
                            color: Color().primaryColor,
                            child: Text(
                              'Register',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20
                              ),
                            ),
                            onPressed: () {
                              showAlertDialog(context);
                            },
                          ),
                        ),
                      ]
                  ),
                ),
              ),
            );
          }
      ),
    );
  }

  void showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = RaisedButton(
      child: Text("Register"),
      color: Colors.green,
      onPressed:  () {
        Navigator.pop(context);
        showAlertDialogSucesso(context);
      },
    );


    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(titulo(event)),
      content: Text("Are you sure you want to register for this event?"),
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

  void showAlertDialogSucesso(BuildContext context) {

    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text('Successfully Registered'),
      content: Text("You are registered in ${titulo(event)}."),
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

  String titulo(String event){
    var arr = event.split(",");
    var arr2 = arr[0].split(": ");

    return arr2[1];
  }

  String data(String event){
    var arr = event.split(",");
    var arr2 = arr[1].split(": ");

    return arr2[1];
  }

  String prazo(String event){
    var arr = event.split(",");
    var arr2 = arr[2].split(": ");

    return arr2[1];
  }

  String local(String event){
    var arr = event.split(",");
    var arr2 = arr[3].split(": ");

    return arr2[1];
  }

  String tipo(String event){
    var arr = event.split(",");
    var arr2 = arr[4].split(": ");

    return arr2[1];
  }

  String custo(String event){
    var arr = event.split(",");
    var arr2 = arr[5].split(": ");

    return arr2[1];
  }

  String imagem(String event){
    var arr = event.split(",");
    var arr2 = arr[6].split(": ");

    return arr2[1].replaceAll('}', '');
  }

}