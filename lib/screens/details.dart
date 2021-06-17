import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import 'package:share/share.dart';
import '../providers/plafond.dart';
import 'package:projeto_tfc/models/event.dart';
import 'home.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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

  var _ratingController;
  double _rating = 3.0;

  double _userRating = 3.0;
  int _ratingBarMode = 1;
  double _initialRating = 2.0;
  bool _isRTLMode = false;
  bool _isVertical = false;

  IconData _selectedIcon;


  @override
  void initState() {
    super.initState();
    _ratingController = TextEditingController(text: '3.0');
    _rating = _initialRating;
  }

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
                          child: event.img!=null ? Image(image: AssetImage('${event.img}'), width: 200,
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
                                     event.dueDate,
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
                                     event.location,
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
                                     event.activities,
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
                                   Text(
                                     'Cost: ',
                                     style: TextStyle(
                                       fontWeight: FontWeight.bold,
                                       fontSize: 17,
                                     ),
                                   ),
                                   Text(
                                     '${event.idx}€',
                                     style: TextStyle(
                                       fontSize: 17,
                                     ),
                                   ),
                                 ],
                               ),
                               SizedBox(height: 30),
                             ],
                           ),
                         ),
                        //_ratingBar(event.rating),
                        SizedBox(height: 50),
                        ButtonTheme(
                          minWidth: 380.0,
                          height: 55.0,
                          child: isInscrito(),
                        ),
                        SizedBox(height: 30),
                      ]
                  ),
                ),
              ),
            );
          }
      ),
    );
  }

  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
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
    final plafond = Provider.of<Plafond>(context);

    if(listEventsReg[index]==true && DateTime.parse(event.dueDate).isAfter(DateTime.now())){
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
          setState(() {
            //plafond.incrementPlafond(event.cost);
            listEventsReg[index] = false;
          });
        },
      );
    }else if(listEventsReg[index]==false && DateTime.parse(event.dueDate).isAfter(DateTime.now())){
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
          /*
          if(plafond.value >= event.cost){
            setState(() {
              listEventsReg[index] = true;
              plafond.decrementPlafond(event.cost);
            });
          }else if(plafond.value < event.cost){
            showAlertDialog(context);
          }
           */

        },
      );
    }else{
      return SizedBox(height: MediaQuery.of(context).size.width);
    }
  }

  Widget _ratingBar(double value) {
    return RatingBar.builder(
      initialRating: value,
      minRating: 1,
      direction: _isVertical ? Axis.vertical : Axis.horizontal,
      allowHalfRating: true,
      unratedColor: Colors.amber.withAlpha(50),
      itemCount: 5,
      itemSize: 50.0,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        _selectedIcon ?? Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        setState(() {
          _rating = rating;
          //event.rating = rating;
        });
      },
      updateOnDrag: true,
    );
  }

}