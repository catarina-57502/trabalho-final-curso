import 'package:flutter/material.dart';
import 'package:projeto_tfc/screens/stats.dart';
import '../constants/colors.dart';

String dropdownValue1 = 'No filter applied';
String dropdownValue2 = 'No filter applied';

class FiltersScreen extends StatefulWidget {
  FiltersScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState(){
    return _FiltersScreenState();
  }

}

class _FiltersScreenState extends State<FiltersScreen>{


  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Filters'),
      ),
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
                        child: Column(
                            children: [
                              SizedBox(height: 30),
                              Text(
                                'Distance',
                                style: TextStyle(
                                    fontSize: 20
                                ),
                              ),
                              SizedBox(height: 10),
                              DropdownButton<String>(
                                value: dropdownValue1,
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdownValue1 = newValue;
                                  });
                                },
                                items: <String>['No filter applied', '5.0km', '10.0km', '21.0km', '42.0km']
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                              SizedBox(height: 60),
                              Text(
                                'Activity Type',
                                style: TextStyle(
                                    fontSize: 20
                                ),
                              ),
                              SizedBox(height: 10),
                              DropdownButton<String>(
                                value: dropdownValue2,
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdownValue2 = newValue;
                                  });
                                },
                                items: <String>['No filter applied', 'Race', 'Walk']
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                              SizedBox(height: 80),
                              ButtonTheme(
                                minWidth: MediaQuery.of(context).size.width,
                                child: RaisedButton(
                                  color: Color().primaryColor,
                                  onPressed: (){
                                    if(dropdownValue1=='No filter applied'){
                                      filterDistance = "N/A";
                                    }else{
                                      filterDistance = dropdownValue1;
                                    }
                                    if(dropdownValue2=='No filter applied'){
                                      filterType = "N/A";
                                    }else{
                                      filterType = dropdownValue2;
                                    }
                                    print(filterType);
                                    print(filterDistance);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => StatsScreen(),
                                        ));
                                  },
                                  padding: EdgeInsets.all(15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    'APPLY FILTERS',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
