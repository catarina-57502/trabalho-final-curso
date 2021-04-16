import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:projeto_tfc/models/times.dart';
import 'package:projeto_tfc/providers/time.dart';
import 'package:projeto_tfc/screens/filters.dart';
import 'package:projeto_tfc/services/api.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../providers/plafond.dart';

Api _api = Api();

bool error = false;

enum ActivityType { race, walk }

var addType;
var addDistance;
var addTime;
var addDate = DateTime.now();

var filterDistance;
var filterType;

Duration initialtimer = new Duration();
int selectitem = 1;

class SimpleTimeSeriesChart extends StatelessWidget {

  final List<charts.Series> seriesList;
  final bool animate;

  SimpleTimeSeriesChart(this.seriesList, {this.animate});


  factory SimpleTimeSeriesChart.withSampleData() {
    return new SimpleTimeSeriesChart(
      _createSampleData(),
      animate: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }

  /// Create one series with sample hard coded data.
   static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {

    var data = List();

    for(var t in _api.userTimes){
      data.add(new TimeSeriesSales( DateTime.parse(t.dateTime), t.time));
    }

    /*
     data = [
      new TimeSeriesSales(new DateTime(2017, 9, 19), 1.50),
      new TimeSeriesSales(new DateTime(2017, 9, 26),  3.50),
      new TimeSeriesSales(new DateTime(2017, 10, 3),  2.33),
      new TimeSeriesSales(new DateTime(2017, 10, 10),  5.01),
    ];
     */


    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Times',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.date,
        measureFn: (TimeSeriesSales sales, _) => sales.time,
        data: data,
      )
    ];
  }
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime date;
  final double time;

  TimeSeriesSales(this.date, this.time);
}

class StatsScreen extends StatefulWidget {
  StatsScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState(){
    return _StatsScreenState();
  }

}

class _StatsScreenState extends State<StatsScreen>{

  String time;
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

   static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
    var data = List<TimeSeriesSales>();


    for(var t in _api.userTimes){
      data.add(new TimeSeriesSales( DateTime.parse(t.dateTime), t.time));
    }


    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Times',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.date,
        measureFn: (TimeSeriesSales sales, _) => sales.time,
        data: data,
      )
    ];
  }

  String getSlowestTime(var byType, var byDistance){
    var valueTemp, arr;
    List list;

    if(byType==null && byDistance==null){
      if (_api.userTimes != null && _api.userTimes.isNotEmpty) {
        valueTemp = _api.userTimes.map<double>((e) => e.time).reduce(max);
      }
    }else if(byDistance!=null){
      if (_api.userTimes != null && _api.userTimes.isNotEmpty) {
        for(FinishTime i in _api.userTimes){
          if(i.distance==byDistance){
            list.add(i);
          }
        }
        if(list!=null && list.isNotEmpty ){
          valueTemp = list.map<double>((e) => e.time).reduce(max);
        }
      }
    }else if(byType!=null){
      if (_api.userTimes != null && _api.userTimes.isNotEmpty) {
        for(FinishTime i in _api.userTimes){
          if(i.activityType==byDistance){
            list.add(i);
          }
        }
        if(list!=null && list.isNotEmpty ){
          valueTemp = list.map<double>((e) => e.time).reduce(max);
        }
      }
    }else if(byType!=null && byDistance!=null){
      if (_api.userTimes != null && _api.userTimes.isNotEmpty) {
        for(FinishTime i in _api.userTimes){
          if(i.activityType==byDistance && i.distance==byDistance){
            list.add(i);
          }
        }
        if(list!=null && list.isNotEmpty ){
          valueTemp = list.map<double>((e) => e.time).reduce(max);
        }
      }
    }

    arr = valueTemp.toString().split('.');
    if(arr[0]=='0'){
      return arr[1]+"min";
    }
    return arr[0]+"h"+arr[1]+"min";
  }

  String getFastestTime(var byType, var byDistance){
    var valueTemp, arr;
    List list;
    if(byType==null && byDistance==null){
      if (_api.userTimes != null && _api.userTimes.isNotEmpty) {
        valueTemp = _api.userTimes.map<double>((e) => e.time).reduce(min);
      }
    }else if(byDistance!=null){
      if (_api.userTimes != null && _api.userTimes.isNotEmpty) {
        for(FinishTime i in _api.userTimes){
          if(i.distance==byDistance){
            list.add(i);
          }
        }
        if(list!=null && list.isNotEmpty ){
          valueTemp = list.map<double>((e) => e.time).reduce(min);
        }
      }
    }else if(byType!=null){
      if (_api.userTimes != null && _api.userTimes.isNotEmpty) {
        for(FinishTime i in _api.userTimes){
          if(i.activityType==byDistance){
            list.add(i);
          }
        }
        if(list!=null && list.isNotEmpty ){
          valueTemp = list.map<double>((e) => e.time).reduce(min);
        }
      }
    }else if(byType!=null && byDistance!=null){
      if (_api.userTimes != null && _api.userTimes.isNotEmpty) {
        for(FinishTime i in _api.userTimes){
          if(i.activityType==byDistance && i.distance==byDistance){
            list.add(i);
          }
        }
        if(list!=null && list.isNotEmpty ){
          valueTemp = list.map<double>((e) => e.time).reduce(min);
        }
      }
    }

    arr = valueTemp.toString().split('.');
    if(arr[0]=='0'){
      return arr[1]+"min";
    }
    return arr[0]+"h"+arr[1]+"min";
  }

  Widget filters(){
    if(filterDistance==null || filterType==null){
      return Text(
        'No filters applied'
      );
    }else if(filterDistance!=null && filterType==null){
      return Text(
        'Distance: $filterDistance'
      );
    }else if(filterDistance==null && filterType!=null){
      return Text(
          'Type: $filterType'
      );
    }else{
      return Text(
          'Distance: $filterDistance | Type: $filterType'
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final plafond = Provider.of<Plafond>(context, listen: false);

    return MultiProvider(
        providers: [
    ChangeNotifierProvider<Time>(
    builder: (context) => Time(),
    ),
    ],
    child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text('Statistics'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.filter_alt_sharp, color: Colors.white),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FiltersScreen(),
                      ));
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
                        Container(
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                    SizedBox(height: 5),
                                    filters(),
                                    SizedBox(height: 40),
                                    Padding(
                                      padding: EdgeInsets.all(1.0),
                                      child: Text("Your Finish Times", style: TextStyle(
                                        fontSize: 25.0,
                                        color: Colors.black,
                                      ),),
                                    ),
                                    Padding(
                                      padding: new EdgeInsets.all(32.0),
                                      child: new SizedBox(
                                        height: 200.0,
                                        width: 340,
                                        child: new charts.TimeSeriesChart(
                                          _createSampleData(),
                                          animate: true,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Card(
                                            elevation: 7,
                                            child: Padding(
                                                padding: const EdgeInsets.all(22.0),
                                                child: Column(
                                                    children: [
                                                      Text('Fastest Time',
                                                        style: TextStyle(
                                                            fontSize: 19,
                                                            fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 24,
                                                        width: 0,
                                                      ),
                                                      Text(getFastestTime(filterType, filterDistance),
                                                        style: TextStyle(
                                                            fontSize: 18
                                                        ),
                                                      ),
                                                    ]
                                                )
                                            )
                                        ),
                                        Card(
                                            elevation: 7,
                                            child: Padding(
                                                padding: const EdgeInsets.all(22.0),
                                                child: Column(
                                                    children: [
                                                      Text('Slowest Time',
                                                        style: TextStyle(
                                                            fontSize: 19,
                                                            fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 24,
                                                        width: 0,
                                                      ),
                                                      Text(getSlowestTime(filterType, filterDistance),
                                                        style: TextStyle(
                                                            fontSize: 18
                                                        ),
                                                      ),
                                                    ]
                                                )
                                            )
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 60),
                                    FloatingActionButton.extended(
                                      onPressed: () {
                                        showAddTimeDialog(context);
                                      },
                                      label: Text('Add a Time',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white
                                        ),
                                      ),
                                      icon: Icon(Icons.add,
                                          color: Colors.white
                                      ),
                                      backgroundColor: Color().primaryColor,
                                    ),
                                    SizedBox(height: 35),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
      ),
    ),
    );

  }

  showAddTimeDialog(BuildContext context) async {
    ActivityType _type = ActivityType.race;
    final time = Provider.of<Time>(context, listen: false);
    var result = DateTime.now();

    var addDistanceTemp;

    double convertTime(String value){
      var arr = value.split(':');

      return double.parse(arr[0]+"."+arr[1]);
    }

    // set up the button
    Widget okButton = FlatButton(
      child: Text("ADD"),
      onPressed: () {
        if(time.value!="0:0:0" && myController.text.isNotEmpty){
          addDistanceTemp = myController.text;
          addDistance = double.parse(addDistanceTemp);
          print(_api.userTimes.length);
          setState(() {
            _api.userTimes.add(FinishTime(activityType: addType, distance: addDistance, dateTime: addDate.toString(), time: convertTime(addTime)));
          });
          setState(() {
            error = false;
          });
          Navigator.pop(context);
        }else{
          setState(() {
            error = true;
          });
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Add a Time"),
      actions:
      [
        okButton,
      ],
      content:  MultiProvider(
        providers: [
          ChangeNotifierProvider<Time>(
            builder: (context) => Time(),
          ),
        ],
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {;
          return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(
                          Icons.directions_run
                      ),
                      SizedBox(width: 3),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text('Activity Type:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ]
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<ActivityType>(
                          title: const Text('Race'),
                          value: ActivityType.race,
                          groupValue: _type,
                          onChanged: (ActivityType value) {
                            setState(() {
                              _type = value;
                              addType = 'Race';
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<ActivityType>(
                          title: const Text('Walk'),
                          value: ActivityType.walk,
                          groupValue: _type,
                          onChanged: (ActivityType value) {
                            setState(() {
                              _type = value;
                              addType = 'Walk';
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Row(
                    children: [
                      Icon(
                          Icons.calendar_today
                      ),
                      SizedBox(width: 3),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text('Date:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Container(
                        width: 100.0,
                        height: 30,
                        padding: EdgeInsets.only(left: 7, top: 7),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.grey)
                        ),
                        child: new GestureDetector(
                          onTap:() async {
                            var resultFuture = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2022));

                          setState(() {
                            result = resultFuture;
                            addDate = result;
                          });

                          },
                          child: Text('${result.toString()}'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Row(
                    children: [
                      Icon(
                          Icons.assistant_photo
                      ),
                      SizedBox(width: 3),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text('Distance:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Container(
                        width: 70.0,
                        height: 30,
                        child: TextField(
                          controller: myController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(width: 3),
                      Text(
                          'km'
                      )
                    ],
                  ),
                  SizedBox(height: 25),
                  Row(
                    children: [
                      Icon(
                          Icons.timer,
                      ),
                      SizedBox(width: 3),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text('Finish Time:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Container(
                        width: 80.0,
                        height: 30,
                        padding: EdgeInsets.only(left: 7, top: 7),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.grey)
                        ),
                        child: new GestureDetector(
                          onTap:(){
                             bottomSheet(context,
                                 CupertinoTimerPicker(
                                   mode: CupertinoTimerPickerMode.hms,
                                   minuteInterval: 1,
                                   secondInterval: 1,
                                   initialTimerDuration: initialtimer,
                                   onTimerDurationChanged: (Duration changedtimer) {
                                     setState(() {
                                       initialtimer = changedtimer;
                                       time.setTime(changedtimer.inHours.toString() +
                                           ':' +
                                           (changedtimer.inMinutes % 60).toString() +
                                           ':' +
                                           (changedtimer.inSeconds % 60).toString());
                                       addTime = time.value;
                                     });

                                   },
                                 )
                             );
                          },
                          child: Text('${time.value}'),
                          ),
                        ),
                      SizedBox(width: 3),
                      Text(
                          'h'
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  error? Text(
                    'Enter a valid Distance and Finish Time value',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ) :
                  Text(
                    '',
                  ),
                ],
              ),
          );
        },
      ),
      ),
    );

    // show the dialog
    await showDialog (
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );

  }

  Future<void> bottomSheet(BuildContext context, Widget child,
      {double height}) {
    return showModalBottomSheet(
        isScrollControlled: false,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(13), topRight: Radius.circular(13))),
        backgroundColor: Colors.white,
        context: context,
        builder: (context) => Container(
            height: height ?? MediaQuery.of(context).size.height / 3,
            child: child));
  }

}