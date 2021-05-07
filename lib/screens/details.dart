import 'package:flutter/material.dart';
import 'package:projeto_tfc/services/api.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import 'package:share/share.dart';
import '../providers/plafond.dart';
import 'package:projeto_tfc/models/event.dart';

List<bool> listEventsReg = List.filled(Api().events.length, false);

class DetailsScreen extends StatefulWidget {

  final event;
  final index;

  DetailsScreen(this.event, this.index);

  @override
  State<StatefulWidget> createState(){
    return _DetailsScreenState(event, index);
  }

}

class _DetailsScreenState extends State<DetailsScreen>{

  final Event event;
  final int index;

  _DetailsScreenState(this.event, this.index);

  @override
  Widget build(BuildContext context) {
    final plafond = Provider.of<Plafond>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          event.name,
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.share, color: Colors.white),
              onPressed: (){
                Share.share("Vou à prova ${event.name} com a minha empresa :)");
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
                        Center(
                          child: event.image!=null ? Image(image: AssetImage('${event.image}'), width: 200,
                            height: 150,)
                              : SizedBox(height: 120),
                        ),
                        SizedBox(height: 50),
                         Container(
                           margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/3.5),
                           child: Column(
                             children: [
                               Row(
                                 children: [
                                   Icon(
                                       Icons.date_range
                                   ),
                                   SizedBox(width: 5),
                                   Text(
                                     'Date: ',
                                     style: TextStyle(
                                       fontWeight: FontWeight.bold,
                                       fontSize: 17,
                                     ),
                                   ),
                                   Text(
                                     event.date,
                                     style: TextStyle(
                                       fontSize: 17,
                                     ),
                                   ),
                                 ],
                               ),
                               SizedBox(height: 20),
                               Row(
                                 children: [
                                   Icon(
                                       Icons.lock_clock
                                   ),
                                   SizedBox(width: 5),
                                   Text(
                                     'Deadline: ',
                                     style: TextStyle(
                                       fontWeight: FontWeight.bold,
                                       fontSize: 17,
                                     ),
                                   ),
                                   Text(
                                     event.deadline,
                                     style: TextStyle(
                                       fontSize: 17,
                                     ),
                                   ),
                                 ],
                               ),
                               SizedBox(height: 20),
                               Row(
                                 children: [
                                   Icon(
                                       Icons.location_on
                                   ),
                                   SizedBox(width: 5),
                                   Text(
                                     'Local: ',
                                     style: TextStyle(
                                       fontWeight: FontWeight.bold,
                                       fontSize: 17,
                                     ),
                                   ),
                                   Text(
                                     event.local,
                                     style: TextStyle(
                                       fontSize: 17,
                                     ),
                                   ),
                                 ],
                               ),
                               SizedBox(height: 20),
                               Row(
                                 children: [
                                   Icon(
                                       Icons.directions_run
                                   ),
                                   SizedBox(width: 5),
                                   Text(
                                     'Type: ',
                                     style: TextStyle(
                                       fontWeight: FontWeight.bold,
                                       fontSize: 17,
                                     ),
                                   ),
                                   Text(
                                     event.type,
                                     style: TextStyle(
                                       fontSize: 17,
                                     ),
                                   ),
                                 ],
                               ),
                               SizedBox(height: 20),
                               Row(
                                 children: [
                                   Icon(
                                       Icons.monetization_on
                                   ),
                                   SizedBox(width: 5),
                                   Text(
                                     'Cost: ',
                                     style: TextStyle(
                                       fontWeight: FontWeight.bold,
                                       fontSize: 17,
                                     ),
                                   ),
                                   Text(
                                     '${event.cost}€',
                                     style: TextStyle(
                                       fontSize: 17,
                                     ),
                                   ),
                                 ],
                               ),
                             ],
                           ),
                         ),
                        SizedBox(height: 50),
                        ButtonTheme(
                          minWidth: 380.0,
                          height: 55.0,
                          child: isInscrito(),
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
    final plafond = Provider.of<Plafond>(context);
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
        if(plafond.value >= event.cost){
          setState(() {
            listEventsReg[index] = true;
            plafond.decrementPlafond(event.cost);
          });
          Navigator.pop(context);
        }else if(plafond.value < event.cost){
          showAlertDialog3(context);
        }
      },
    );


    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(event.name),
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

  void showAlertDialog2(BuildContext context) {
    final plafond = Provider.of<Plafond>(context);
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("No"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = RaisedButton(
      child: Text("Yes, Cancel"),
      color: Colors.red,
      onPressed:  () {
        setState(() {
          plafond.incrementPlafond(event.cost);
          listEventsReg[index] = false;
        });
        Navigator.pop(context);
      },
    );


    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(event.name),
      content: Text("Are you sure you want to cancel you registration for this event?"),
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

  showAlertDialog3(BuildContext context) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(event.name),
      content: Text("Your plafond is not enough to register for this event."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget isInscrito(){
    if(listEventsReg[index]==true && DateTime.parse(event.deadline).isAfter(DateTime.now())){
      return RaisedButton(
        color: Colors.red,
        child: Text(
          'Cancel',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20
          ),
        ),
        onPressed: () {
          showAlertDialog2(context);
        },
      );
    }else if(listEventsReg[index]==false && DateTime.parse(event.deadline).isAfter(DateTime.now())){
      return RaisedButton(
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
      );
    }else{
      return SizedBox(height: MediaQuery.of(context).size.width);
    }
  }
}