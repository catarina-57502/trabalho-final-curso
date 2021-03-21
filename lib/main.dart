import 'package:flutter/material.dart';
import 'package:projeto_tfc/eventsToApprove.dart';
import 'package:fcharts/fcharts.dart';
import 'package:projeto_tfc/times.dart';
import 'events.dart';
import 'memberToApprove.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema de Gestão de Eventos',
      theme: ThemeData(
          primarySwatch: Colors.cyan,
          primaryTextTheme: TextTheme(
              headline6: TextStyle(
                  color: Colors.white
              )
          )
      ),
      home: LoginScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState(){
    return _HomeScreenState();
  }

}

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState(){
    return _LoginScreenState();
  }

}

class EventsListScreen extends StatefulWidget {
  EventsListScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState(){
    return _EventsListScreenState();
  }

}

class MembersListScreen extends StatefulWidget {
  MembersListScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState(){
    return _MembersListScreenState();
  }

}

class StatsScreen extends StatefulWidget {
  StatsScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState(){
    return _StatsScreenState();
  }

}

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

class _HomeScreenState extends State<HomeScreen>{

  TextEditingController _controller;

  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget event(list) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: RichText(
        text: TextSpan(
          text: '${list['name']}',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20
          ),
          children: <TextSpan>[
            TextSpan(text: '\n${list['date']}', style: TextStyle(color: Colors.grey, fontSize: 15,)),
          ],
        ),
      ),
    );
  }

  Widget image(list) {
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Image(image: AssetImage('${list['image']}'), width: 100,
          height: 150,)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: null
          )
        ],
      ),
      body: ListView.builder(
          itemCount: Events.getEvents.length, // the length
          itemBuilder: (context, index) {
            return new GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(Events.getEvents[index].toString()),
                      ));
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(15,15,15,0),
                  height: 200,
                  child: Card(
                    elevation: 7,
                    child: Row(
                      children: [
                        image(Events.getEvents[index]),
                        event(Events.getEvents[index])
                      ],
                    ),
                  ),
                )

            );
          }),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.cyan,
                ),
                child: Container(
                  child: Column(
                      children: <Widget>[
                        Material(
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                            child: Icon(Icons.person, color: Colors.blueGrey, size: 80)
                        ),
                        Padding(padding: EdgeInsets.all(15.0),
                          child: Text(
                            'John Doe',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )
                      ]
                  ),

                )
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text(
                'Home',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onTap: () {

                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.event),
              title: Text(
                'Events List',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EventsListScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text(
                'Members List',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MembersListScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.bar_chart),
              title: Text(
                'Statistics',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StatsScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                    LoginScreen()), (Route<dynamic> route) => false
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginScreenState extends State<LoginScreen>{

  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      SingleChildScrollView(
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
            SizedBox(height: 40),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Username',
                  style: TextStyle(
                    color: Colors.cyan,
                    fontSize: 17,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft,
              height: 60,
              width: 380,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black),
              ),
              child: TextField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.cyan,
                  ),
                  hintText: 'Enter Username',
                ),
              ),
            ),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Password',
                  style: TextStyle(
                    color: Colors.cyan,
                    fontSize: 17,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft,
              height: 60,
              width: 380,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black),
              ),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.cyan,
                  ),
                  hintText: '**********',
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.only(left: 5),
              child: Row(
                children: <Widget>[
                  Theme(
                    data: ThemeData(unselectedWidgetColor: Colors.black),
                    child: Checkbox(
                      value: _rememberMe,
                      checkColor: Colors.white,
                      activeColor: Colors.cyan,
                      onChanged: (value) {
                        setState(() {
                          _rememberMe = value;
                        });
                      },
                    ),
                  ),
                  Text(
                    'Remember me',
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            ButtonTheme(
              minWidth: 380,
              child: RaisedButton(
                color: Colors.cyan,
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen(title: 'Sistema de Gestão de Eventos')),
                  );
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
    );
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
      body: ListView.builder(
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
    );
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

class SimpleLineChart extends StatelessWidget {
  // X value -> Y value
  static const myData = [
    ["A", "✔"],
    ["B", "❓"],
    ["C", "✖"],
    ["D", "❓"],
    ["E", "✖"],
    ["F", "✖"],
    ["G", "✔"],
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: new LineChart(
        lines: [
          new Line<List<String>, String, String>(
            data: myData,
            xFn: (datum) => datum[0],
            yFn: (datum) => datum[1],
          ),
        ],
        chartPadding: new EdgeInsets.fromLTRB(30.0, 10.0, 10.0, 30.0),
      ),
    );
  }
}

class ChartExample {
  ChartExample(
      this.name,
      this.widget,
      this.description,
      );

  final String name;
  final Widget widget;
  final String description;
}

final charts = [
  new ChartExample(
    'Simple Line Chart',
    new SimpleLineChart(),
    'Strings on the X-Axis and their index in the list on the Y-Axis.',
  ),
];

class _StatsScreenState extends State<StatsScreen>{

  var _chartIndex = 0;

  @override
  Widget build(BuildContext context) {

    final chart = charts[_chartIndex % charts.length];

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text('Statistics'),
        ),
        body: Container(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(1.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(1.0),
                        child: Text("Your Race Finish Times", style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.black,
                        ),),
                      ),
                      SizedBox(height: 35),
                      Padding(
                        padding: new EdgeInsets.all(20.0),
                        child: chart.widget,
                      ),
                      SizedBox(height: 40),
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
                      SizedBox(height: 70),
                      FloatingActionButton.extended(
                        onPressed: () {
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
                        backgroundColor: Colors.cyan,
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        )
    );
  }
}