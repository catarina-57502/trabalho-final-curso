import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';
import 'colors.dart';
import 'plafond.dart';

enum ActivityType { run, walk }

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
    final data = [
      new TimeSeriesSales(new DateTime(2017, 9, 19), 1.50),
      new TimeSeriesSales(new DateTime(2017, 9, 26),  3.50),
      new TimeSeriesSales(new DateTime(2017, 10, 3),  2.33),
      new TimeSeriesSales(new DateTime(2017, 10, 10),  5.01),
    ];

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

  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
    final data = [
      new TimeSeriesSales(new DateTime(2017, 9, 19), 1.50),
      new TimeSeriesSales(new DateTime(2017, 9, 26),  3.50),
      new TimeSeriesSales(new DateTime(2017, 10, 3),  2.33),
      new TimeSeriesSales(new DateTime(2017, 10, 10),  5.01),
    ];


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

  @override
  Widget build(BuildContext context) {
    final plafond = Provider.of<Plafond>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Statistics'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.filter_alt_sharp, color: Colors.white),
              onPressed: (){
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
                                  SizedBox(height: 20),
                                  Padding(
                                    padding: EdgeInsets.all(1.0),
                                    child: Text("Your Race Finish Times", style: TextStyle(
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
                                                    Text('35min',
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
                                                    Text('5h56min',
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
    );
  }

  showAddTimeDialog(BuildContext context) {

    ActivityType _type;

    // set up the button
    Widget okButton = FlatButton(
      child: Text("ADD"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Add a Time"),
      content: new Column(
          children:[
            Row(
              children: [
                Expanded(
                  child:ListTile(
                    title: const Text('Race'),
                    leading: Radio<ActivityType>(
                      value: ActivityType.run,
                      groupValue: _type,
                      onChanged: (ActivityType value) {
                        setState(() {
                          _type = value;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Walk'),
                    leading: Radio<ActivityType>(
                      value: ActivityType.walk,
                      groupValue: _type,
                      onChanged: (ActivityType value) {
                        setState(() {
                          _type = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            )
          ]

      ),
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


}