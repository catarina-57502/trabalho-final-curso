import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:projeto_tfc/models/times.dart';
import 'package:projeto_tfc/providers/time.dart';
import 'package:projeto_tfc/screens/filters.dart';
import 'package:projeto_tfc/screens/home.dart';
import 'package:projeto_tfc/screens/login.dart';
import 'package:projeto_tfc/services/api.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../providers/plafond.dart';

Api _api = Api();

bool error = true;

enum ActivityType { race, walk }

var addType;
var addDistance;
var addTime;
var addDate = DateTime.now();

var filterDistance = "N/A";
var filterType = "N/A";
var filterDateRange = "N/A";

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

    if(filterType=="N/A" && filterDistance=="N/A"){
      for(var t in _api.userTimes){
        data.add(new TimeSeriesSales( DateTime.parse(t.dateTime), t.time));
      }
    }else if(filterDistance!="N/A" && filterType=="N/A"){
      for(var t in _api.userTimes){
        if('${t.distance}km'==filterDistance){
          data.add(new TimeSeriesSales( DateTime.parse(t.dateTime), t.time));
        }
      }
    }else if(filterDistance=="N/A" && filterType!="N/A"){
      for(var t in _api.userTimes){
        if(t.activityType==filterType){
          data.add(new TimeSeriesSales( DateTime.parse(t.dateTime), t.time));
        }
      }
    }else if(filterDistance!="N/A" && filterType!="N/A"){
      for(var t in _api.userTimes){
        if('${t.distance}km'==filterDistance && t.activityType==filterType){
          data.add(new TimeSeriesSales( DateTime.parse(t.dateTime), t.time));
        }
      }
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


    if(filterType=="N/A" && filterDistance=="N/A" && filterDateRange=="N/A"){
      for(var t in _api.userTimes){
        data.add(new TimeSeriesSales( DateTime.parse(t.dateTime), t.time));
      }
    }else if(filterDistance!="N/A" && filterType=="N/A" && filterDateRange=="N/A"){
      for(var t in _api.userTimes){
        if('${t.distance}km'==filterDistance){
          data.add(new TimeSeriesSales( DateTime.parse(t.dateTime), t.time));
        }
      }
    }else if(filterDistance=="N/A" && filterType!="N/A" && filterDateRange=="N/A"){
      for(var t in _api.userTimes){
        if(t.activityType==filterType){
          data.add(new TimeSeriesSales( DateTime.parse(t.dateTime), t.time));
        }
      }
    }else if(filterDistance!="N/A" && filterType!="N/A" && filterDateRange=="N/A"){
      for(var t in _api.userTimes){
        if('${t.distance}km'==filterDistance && t.activityType==filterType){
          data.add(new TimeSeriesSales( DateTime.parse(t.dateTime), t.time));
        }
      }
    }else if(filterDistance=="N/A" && filterType=="N/A" && filterDateRange!="N/A"){
      for(var t in _api.userTimes){
        if(DateTime.parse(t.dateTime).isAfter(DateTime.parse(filterDateRange.split(' to ')[0])) && DateTime.parse(t.dateTime).isBefore(DateTime.parse(filterDateRange.split(' to ')[1])) || DateTime.parse(t.dateTime)==(DateTime.parse(filterDateRange.split(' to ')[0])) || DateTime.parse(t.dateTime)==(DateTime.parse(filterDateRange.split(' to ')[1]))){
          data.add(new TimeSeriesSales( DateTime.parse(t.dateTime), t.time));
        }
      }
    }else if(filterDistance!="N/A" && filterType=="N/A" && filterDateRange!="N/A"){
      for(var t in _api.userTimes){
        if('${t.distance}km'==filterDistance && (DateTime.parse(t.dateTime).isAfter(DateTime.parse(filterDateRange.split(' to ')[0])) && DateTime.parse(t.dateTime).isBefore(DateTime.parse(filterDateRange.split(' to ')[1])) || DateTime.parse(t.dateTime)==(DateTime.parse(filterDateRange.split(' to ')[0])) || DateTime.parse(t.dateTime)==(DateTime.parse(filterDateRange.split(' to ')[1])))){
          data.add(new TimeSeriesSales( DateTime.parse(t.dateTime), t.time));
        }
      }
    }else if(filterDistance=="N/A" && filterType!="N/A" && filterDateRange!="N/A"){
      for(var t in _api.userTimes){
        if(t.activityType==filterType && (DateTime.parse(t.dateTime).isAfter(DateTime.parse(filterDateRange.split(' to ')[0])) && DateTime.parse(t.dateTime).isBefore(DateTime.parse(filterDateRange.split(' to ')[1])) || DateTime.parse(t.dateTime)==(DateTime.parse(filterDateRange.split(' to ')[0])) || DateTime.parse(t.dateTime)==(DateTime.parse(filterDateRange.split(' to ')[1])))){
          data.add(new TimeSeriesSales( DateTime.parse(t.dateTime), t.time));
        }
      }
    }else if(filterDistance!="N/A" && filterType!="N/A" && filterDateRange!="N/A"){
      for(var t in _api.userTimes){
        if('${t.distance}km'==filterDistance && t.activityType==filterType && (DateTime.parse(t.dateTime).isAfter(DateTime.parse(filterDateRange.split(' to ')[0])) && DateTime.parse(t.dateTime).isBefore(DateTime.parse(filterDateRange.split(' to ')[1])) || DateTime.parse(t.dateTime)==(DateTime.parse(filterDateRange.split(' to ')[0])) || DateTime.parse(t.dateTime)==(DateTime.parse(filterDateRange.split(' to ')[1])))){
          data.add(new TimeSeriesSales( DateTime.parse(t.dateTime), t.time));
        }
      }
    }


    data.sort((a,b) => a.date.compareTo(b.date));

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

  String getSlowestTime(var byType, var byDistance, var byDate){
    var valueTemp=0.0, arr;
    List list = List();

    valueTemp = 0.0;

    if(byType=="N/A" && byDistance=="N/A" && byDate=="N/A"){
      if (_api.userTimes != null && _api.userTimes.isNotEmpty) {
        valueTemp = _api.userTimes.map<double>((e) => e.time).reduce(max);
      }
    }else if(byDistance!="N/A" && byType=="N/A" && byDate=="N/A"){
      if (_api.userTimes != null && _api.userTimes.isNotEmpty) {
        for(FinishTime i in _api.userTimes){
          if("${i.distance}km"==byDistance){
            list.add(i);
          }
        }
        if(list!=null && list.isNotEmpty ){
          valueTemp = list.map<double>((e) => e.time).reduce(max);
        }
      }
    }else if(byType!="N/A" && byDistance=="N/A" && byDate=="N/A"){
      if (_api.userTimes != null && _api.userTimes.isNotEmpty) {
        for(FinishTime i in _api.userTimes){
          if(i.activityType==byType){
            list.add(i);
          }
        }
        if(list!=null && list.isNotEmpty ){
          valueTemp = list.map<double>((e) => e.time).reduce(max);
        }
      }
    }else if(byType!="N/A" && byDistance!="N/A" && byDate=="N/A"){
      if (_api.userTimes != null && _api.userTimes.isNotEmpty) {
        for(FinishTime i in _api.userTimes){
          if(i.activityType==byType && "${i.distance}km"==byDistance){
            list.add(i);
          }
        }
        if(list!=null && list.isNotEmpty ){
          valueTemp = list.map<double>((e) => e.time).reduce(max);
        }
      }
    }else if(byType=="N/A" && byDistance=="N/A" && byDate!="N/A"){
      if (_api.userTimes != null && _api.userTimes.isNotEmpty) {
        for(FinishTime i in _api.userTimes){
          if(DateTime.parse(i.dateTime).isAfter(DateTime.parse(byDate.split(' to ')[0])) && DateTime.parse(i.dateTime).isBefore(DateTime.parse(byDate.split(' to ')[1])) || DateTime.parse(i.dateTime)==(DateTime.parse(byDate.split(' to ')[0])) || DateTime.parse(i.dateTime)==(DateTime.parse(byDate.split(' to ')[1]))){
            list.add(i);
          }
        }
        if(list!=null && list.isNotEmpty ){
          valueTemp = list.map<double>((e) => e.time).reduce(max);
        }
      }
    }else if(byType!="N/A" && byDistance=="N/A" && byDate!="N/A"){
      if (_api.userTimes != null && _api.userTimes.isNotEmpty) {
        for(FinishTime i in _api.userTimes){
          if(i.activityType==byType && ((DateTime.parse(i.dateTime).isAfter(DateTime.parse(byDate.split(' to ')[0])) && DateTime.parse(i.dateTime).isBefore(DateTime.parse(byDate.split(' to ')[1]))) || DateTime.parse(i.dateTime)==(DateTime.parse(byDate.split(' to ')[0])) || DateTime.parse(i.dateTime)==(DateTime.parse(byDate.split(' to ')[1])))){
            list.add(i);
          }
        }
        if(list!=null && list.isNotEmpty ){
          valueTemp = list.map<double>((e) => e.time).reduce(max);
        }
      }
    }else if(byType=="N/A" && byDistance!="N/A" && byDate!="N/A"){
      if (_api.userTimes != null && _api.userTimes.isNotEmpty) {
        for(FinishTime i in _api.userTimes){
          if("${i.distance}km"==byDistance && ((DateTime.parse(i.dateTime).isAfter(DateTime.parse(byDate.split(' to ')[0])) && DateTime.parse(i.dateTime).isBefore(DateTime.parse(byDate.split(' to ')[1]))) || DateTime.parse(i.dateTime)==(DateTime.parse(byDate.split(' to ')[0])) || DateTime.parse(i.dateTime)==(DateTime.parse(byDate.split(' to ')[1])))){
            list.add(i);
          }
        }
        if(list!=null && list.isNotEmpty ){
          valueTemp = list.map<double>((e) => e.time).reduce(max);
        }
      }
    }else if(byType!="N/A" && byDistance!="N/A" && byDate!="N/A"){
      if (_api.userTimes != null && _api.userTimes.isNotEmpty) {
        for(FinishTime i in _api.userTimes){
          if(i.activityType==byType && "${i.distance}km"==byDistance && ((DateTime.parse(i.dateTime).isAfter(DateTime.parse(byDate.split(' to ')[0])) && DateTime.parse(i.dateTime).isBefore(DateTime.parse(byDate.split(' to ')[1])))  || DateTime.parse(i.dateTime)==(DateTime.parse(byDate.split(' to ')[0])) || DateTime.parse(i.dateTime)==(DateTime.parse(byDate.split(' to ')[1])))){
            list.add(i);
          }
        }
        if(list!=null && list.isNotEmpty ){
          valueTemp = list.map<double>((e) => e.time).reduce(max);
        }
      }
    }
    if(valueTemp!=null && valueTemp!=0){
      arr = valueTemp.toString().split('.');
      if(arr[0]=='0'){
        return arr[1]+"min";
      }
      return arr[0]+"h"+arr[1]+"min";
    }
    return "N/A";
  }

  String getFastestTime(var byType, var byDistance, var byDate){
    var valueTemp = 0.0, arr;
    List list = List();

    if(byType=="N/A" && byDistance=="N/A" && byDate=="N/A"){
      if (_api.userTimes != null && _api.userTimes.isNotEmpty) {
        valueTemp = _api.userTimes.map<double>((e) => e.time).reduce(min);
      }
    }else if(byDistance!="N/A" && byType=="N/A" && byDate=="N/A"){
      if (_api.userTimes != null && _api.userTimes.isNotEmpty) {
        for(FinishTime i in _api.userTimes){
          if("${i.distance}km"==byDistance){
            list.add(i);
            print("1");
          }
        }
        if(list!=null && list.isNotEmpty ){
          valueTemp = list.map<double>((e) => e.time).reduce(min);
        }
      }
    }else if(byType!="N/A" && byDistance=="N/A" && byDate=="N/A"){
      if (_api.userTimes != null && _api.userTimes.isNotEmpty) {
        for(FinishTime i in _api.userTimes){
          if(i.activityType==byType){
            list.add(i);
          }
        }
        if(list!=null && list.isNotEmpty){
          valueTemp = list.map<double>((e) => e.time).reduce(min);
        }
      }
    }else if(byType!="N/A" && byDistance!="N/A" && byDate=="N/A"){
      if (_api.userTimes != null && _api.userTimes.isNotEmpty) {
        for(FinishTime i in _api.userTimes){
          if(i.activityType==byType && "${i.distance}km"==byDistance){
            list.add(i);
          }
        }
        if(list!=null && list.isNotEmpty ){
          valueTemp = list.map<double>((e) => e.time).reduce(min);
        }
      }
    }else if(byType=="N/A" && byDistance=="N/A" && byDate!="N/A"){
      if (_api.userTimes != null && _api.userTimes.isNotEmpty) {
        for(FinishTime i in _api.userTimes){
          if((DateTime.parse(i.dateTime).isAfter(DateTime.parse(byDate.split(' to ')[0])) && DateTime.parse(i.dateTime).isBefore(DateTime.parse(byDate.split(' to ')[1]))) || DateTime.parse(i.dateTime)==(DateTime.parse(byDate.split(' to ')[0])) || DateTime.parse(i.dateTime)==(DateTime.parse(byDate.split(' to ')[1]))){
            list.add(i);
          }
        }
        if(list!=null && list.isNotEmpty ){
          valueTemp = list.map<double>((e) => e.time).reduce(min);
        }
      }
    }else if(byType!="N/A" && byDistance=="N/A" && byDate!="N/A"){
      if (_api.userTimes != null && _api.userTimes.isNotEmpty) {
        for(FinishTime i in _api.userTimes){
          if(i.activityType==byType && ((DateTime.parse(i.dateTime).isAfter(DateTime.parse(byDate.split(' to ')[0])) && DateTime.parse(i.dateTime).isBefore(DateTime.parse(byDate.split(' to ')[1]))) || DateTime.parse(i.dateTime)==(DateTime.parse(byDate.split(' to ')[0])) || DateTime.parse(i.dateTime)==(DateTime.parse(byDate.split(' to ')[1])))){
            list.add(i);
          }
        }
        if(list!=null && list.isNotEmpty ){
          valueTemp = list.map<double>((e) => e.time).reduce(min);
        }
      }
    }else if(byType=="N/A" && byDistance!="N/A" && byDate!="N/A"){
      if (_api.userTimes != null && _api.userTimes.isNotEmpty) {
        for(FinishTime i in _api.userTimes){
          if("${i.distance}km"==byDistance && ((DateTime.parse(i.dateTime).isAfter(DateTime.parse(byDate.split(' to ')[0])) && DateTime.parse(i.dateTime).isBefore(DateTime.parse(byDate.split(' to ')[1]))) || DateTime.parse(i.dateTime)==(DateTime.parse(byDate.split(' to ')[0])) || DateTime.parse(i.dateTime)==(DateTime.parse(byDate.split(' to ')[1])))){
            list.add(i);
          }
        }
        if(list!=null && list.isNotEmpty ){
          valueTemp = list.map<double>((e) => e.time).reduce(min);
        }
      }
    }else if(byType!="N/A" && byDistance!="N/A" && byDate!="N/A"){
      if (_api.userTimes != null && _api.userTimes.isNotEmpty) {
        for(FinishTime i in _api.userTimes){
          if(i.activityType==byType && "${i.distance}km"==byDistance && ((DateTime.parse(i.dateTime).isAfter(DateTime.parse(byDate.split(' to ')[0])) && DateTime.parse(i.dateTime).isBefore(DateTime.parse(byDate.split(' to ')[1]))) || DateTime.parse(i.dateTime)==(DateTime.parse(byDate.split(' to ')[0])) || DateTime.parse(i.dateTime)==(DateTime.parse(byDate.split(' to ')[1])))){
            list.add(i);
          }
        }
        if(list!=null && list.isNotEmpty ){
          valueTemp = list.map<double>((e) => e.time).reduce(min);
        }
      }
    }

    if(valueTemp!=null && valueTemp!=0){
      arr = valueTemp.toString().split('.');
      if(arr[0]=='0'){
        return arr[1]+"min";
      }
      return arr[0]+"h"+arr[1]+"min";
    }
    return "N/A";
  }

  String getTotalTime(var byType, var byDistance, var byDate){
    var valueTemp=0.0, arr;
    List list = List();

    if(byType=="N/A" && byDistance=="N/A" && byDate=="N/A"){
      if (_api.userTimes != null && _api.userTimes.isNotEmpty) {
        _api.userTimes.forEach((e) => valueTemp += e.time);
      }
    }else if(byDistance!="N/A" && byType=="N/A" && byDate=="N/A"){
      if (_api.userTimes != null && _api.userTimes.isNotEmpty) {
        for(FinishTime i in _api.userTimes){
          if("${i.distance}km"==byDistance){
            list.add(i);
          }
        }
        if(list!=null && list.isNotEmpty ){
          list.forEach((e) => valueTemp += e.time);
        }
      }
    }else if(byType!="N/A" && byDistance=="N/A" && byDate=="N/A"){
      if (_api.userTimes != null && _api.userTimes.isNotEmpty) {
        for(FinishTime i in _api.userTimes){
          if(i.activityType==byType){
            list.add(i);
          }
        }
        if(list!=null && list.isNotEmpty ){
          list.forEach((e) => valueTemp += e.time);
        }
      }
    }else if(byType!="N/A" && byDistance!="N/A" && byDate=="N/A"){
      if (_api.userTimes != null && _api.userTimes.isNotEmpty) {
        for(FinishTime i in _api.userTimes){
          if(i.activityType==byType && "${i.distance}km"==byDistance){
            list.add(i);
          }
        }
        if(list!=null && list.isNotEmpty ){
          list.forEach((e) => valueTemp += e.time);
        }
      }
    }else if(byType=="N/A" && byDistance=="N/A" && byDate!="N/A"){
      if (_api.userTimes != null && _api.userTimes.isNotEmpty) {
        for(FinishTime i in _api.userTimes){
          if(DateTime.parse(i.dateTime).isAfter(DateTime.parse(byDate.split(' to ')[0])) && DateTime.parse(i.dateTime).isBefore(DateTime.parse(byDate.split(' to ')[1])) || DateTime.parse(i.dateTime)==(DateTime.parse(byDate.split(' to ')[0])) || DateTime.parse(i.dateTime)==(DateTime.parse(byDate.split(' to ')[1]))){
            list.add(i);
          }
        }
        if(list!=null && list.isNotEmpty ){
          list.forEach((e) => valueTemp += e.time);
        }
      }
    }else if(byType!="N/A" && byDistance=="N/A" && byDate!="N/A"){
      if (_api.userTimes != null && _api.userTimes.isNotEmpty) {
        for(FinishTime i in _api.userTimes){
          if(i.activityType==byType && ((DateTime.parse(i.dateTime).isAfter(DateTime.parse(byDate.split(' to ')[0])) && DateTime.parse(i.dateTime).isBefore(DateTime.parse(byDate.split(' to ')[1]))) || DateTime.parse(i.dateTime)==(DateTime.parse(byDate.split(' to ')[0])) || DateTime.parse(i.dateTime)==(DateTime.parse(byDate.split(' to ')[1])))){
            list.add(i);
          }
        }
        if(list!=null && list.isNotEmpty ){
          list.forEach((e) => valueTemp += e.time);
        }
      }
    }else if(byType=="N/A" && byDistance!="N/A" && byDate!="N/A"){
      if (_api.userTimes != null && _api.userTimes.isNotEmpty) {
        for(FinishTime i in _api.userTimes){
          if("${i.distance}km"==byDistance && ((DateTime.parse(i.dateTime).isAfter(DateTime.parse(byDate.split(' to ')[0])) && DateTime.parse(i.dateTime).isBefore(DateTime.parse(byDate.split(' to ')[1]))) || DateTime.parse(i.dateTime)==(DateTime.parse(byDate.split(' to ')[0])) || DateTime.parse(i.dateTime)==(DateTime.parse(byDate.split(' to ')[1])))){
            list.add(i);
          }
        }
        if(list!=null && list.isNotEmpty ){
          list.forEach((e) => valueTemp += e.time);
        }
      }
    }else if(byType!="N/A" && byDistance!="N/A" && byDate!="N/A"){
      if (_api.userTimes != null && _api.userTimes.isNotEmpty) {
        for(FinishTime i in _api.userTimes){
          if(i.activityType==byType && "${i.distance}km"==byDistance && ((DateTime.parse(i.dateTime).isAfter(DateTime.parse(byDate.split(' to ')[0])) && DateTime.parse(i.dateTime).isBefore(DateTime.parse(byDate.split(' to ')[1]))) || DateTime.parse(i.dateTime)==(DateTime.parse(byDate.split(' to ')[0])) || DateTime.parse(i.dateTime)==(DateTime.parse(byDate.split(' to ')[1])))){
            list.add(i);
          }
        }
        if(list!=null && list.isNotEmpty ){
          list.forEach((e) => valueTemp += e.time);
        }
      }
    }


    if(valueTemp!=null && valueTemp!=0){
      arr = valueTemp.toString().split('.');
      if(arr[0]=='0'){
        return arr[1]+"min";
      }
      return arr[0]+"h"+arr[1]+"min";
    }
    return "N/A";
  }

  String getTotalDistance(var byType, var byDistance, var byDate){
    var valueTemp = 0.0, arr;
    List list = List();

    if(byType=="N/A" && byDistance=="N/A" && byDate=="N/A"){
      if (_api.userTimes != null && _api.userTimes.isNotEmpty) {
        _api.userTimes.forEach((e) => valueTemp += e.distance);
      }
    }else if(byDistance!="N/A" && byType=="N/A" && byDate=="N/A"){
      if (_api.userTimes != null && _api.userTimes.isNotEmpty) {
        for(FinishTime i in _api.userTimes){
          if("${i.distance}km"==byDistance){
            list.add(i);
          }
        }
        if(list!=null && list.isNotEmpty ){
          list.forEach((e) => valueTemp += e.distance);
        }
      }
    }else if(byType!="N/A" && byDistance=="N/A" && byDate=="N/A"){
      if (_api.userTimes != null && _api.userTimes.isNotEmpty) {
        for(FinishTime i in _api.userTimes){
          if(i.activityType==byType){
            list.add(i);
          }
        }
        if(list!=null && list.isNotEmpty ){
          list.forEach((e) => valueTemp += e.distance);
        }
      }
    }else if(byType!="N/A" && byDistance!="N/A" && byDate=="N/A"){
      if (_api.userTimes != null && _api.userTimes.isNotEmpty) {
        for(FinishTime i in _api.userTimes){
          if(i.activityType==byType && "${i.distance}km"==byDistance){
            list.add(i);
          }
        }
        if(list!=null && list.isNotEmpty ){
          list.forEach((e) => valueTemp += e.distance);
        }
      }
    }else if(byType=="N/A" && byDistance=="N/A" && byDate!="N/A"){
      if (_api.userTimes != null && _api.userTimes.isNotEmpty) {
        for(FinishTime i in _api.userTimes){
          if(DateTime.parse(i.dateTime).isAfter(DateTime.parse(byDate.split(' to ')[0])) && DateTime.parse(i.dateTime).isBefore(DateTime.parse(byDate.split(' to ')[1])) || DateTime.parse(i.dateTime)==(DateTime.parse(byDate.split(' to ')[0])) || DateTime.parse(i.dateTime)==(DateTime.parse(byDate.split(' to ')[1]))){
            list.add(i);
          }
        }
        if(list!=null && list.isNotEmpty ){
          list.forEach((e) => valueTemp += e.distance);
        }
      }
    }else if(byType!="N/A" && byDistance=="N/A" && byDate!="N/A"){
      if (_api.userTimes != null && _api.userTimes.isNotEmpty) {
        for(FinishTime i in _api.userTimes){
          if(i.activityType==byType && ((DateTime.parse(i.dateTime).isAfter(DateTime.parse(byDate.split(' to ')[0])) && DateTime.parse(i.dateTime).isBefore(DateTime.parse(byDate.split(' to ')[1])))  || DateTime.parse(i.dateTime)==(DateTime.parse(byDate.split(' to ')[0])) || DateTime.parse(i.dateTime)==(DateTime.parse(byDate.split(' to ')[1])))){
            list.add(i);
          }
        }
        if(list!=null && list.isNotEmpty ){
          list.forEach((e) => valueTemp += e.distance);
        }
      }
    }else if(byType=="N/A" && byDistance!="N/A" && byDate!="N/A"){
      if (_api.userTimes != null && _api.userTimes.isNotEmpty) {
        for(FinishTime i in _api.userTimes){
          if("${i.distance}km"==byDistance && ((DateTime.parse(i.dateTime).isAfter(DateTime.parse(byDate.split(' to ')[0])) && DateTime.parse(i.dateTime).isBefore(DateTime.parse(byDate.split(' to ')[1]))) || DateTime.parse(i.dateTime)==(DateTime.parse(byDate.split(' to ')[0])) || DateTime.parse(i.dateTime)==(DateTime.parse(byDate.split(' to ')[1])))){
            list.add(i);
          }
        }
        if(list!=null && list.isNotEmpty ){
          list.forEach((e) => valueTemp += e.distance);
        }
      }
    }else if(byType!="N/A" && byDistance!="N/A" && byDate!="N/A"){
      if (_api.userTimes != null && _api.userTimes.isNotEmpty) {
        for(FinishTime i in _api.userTimes){
          if(i.activityType==byType && "${i.distance}km"==byDistance && ((DateTime.parse(i.dateTime).isAfter(DateTime.parse(byDate.split(' to ')[0])) && DateTime.parse(i.dateTime).isBefore(DateTime.parse(byDate.split(' to ')[1]))) || DateTime.parse(i.dateTime)==(DateTime.parse(byDate.split(' to ')[0])) || DateTime.parse(i.dateTime)==(DateTime.parse(byDate.split(' to ')[1])))){
            list.add(i);
          }
        }
        if(list!=null && list.isNotEmpty ){
          list.forEach((e) => valueTemp += e.distance);
        }
      }
    }


    if(valueTemp!=null && valueTemp!=0){
      return '${valueTemp}km';
    }
    return "N/A";
  }

  Widget filters(){
    if(filterDistance=="N/A" && filterType=="N/A" && filterDateRange=="N/A"){
      return Text(
          'No filters applied'
      );
    }else if(filterDistance!="N/A" && filterType=="N/A" && filterDateRange=="N/A"){
      return Text(
          'Distance: $filterDistance'
      );
    }else if(filterDistance=="N/A" && filterType!="N/A" && filterDateRange=="N/A"){
      return Text(
          'Type: $filterType'
      );
    }else if(filterDistance=="N/A" && filterType=="N/A" && filterDateRange!="N/A"){
      return Text(
          'Date Range: $filterDateRange'
      );
    }else{
      return Text(
          'Distance: $filterDistance | Type: $filterType | Date Range: $filterDateRange'
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final plafond = Provider.of<Plafond>(context, listen: false);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Time>(
          create: (context) => Time(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () =>  Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen('Sistema de Gestão de Eventos', nameAuth, roleAuth),
                )),
          ),
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
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Container(
                                child: Column(
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
                                                            fontSize: (19 / 720) * MediaQuery.of(context).size.height,
                                                            fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 24,
                                                        width: 0,
                                                      ),
                                                      Text(getFastestTime(filterType, filterDistance, filterDateRange),
                                                        style: TextStyle(
                                                            fontSize: (18 / 720) * MediaQuery.of(context).size.height
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
                                                            fontSize: (19 / 720) * MediaQuery.of(context).size.height,
                                                            fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 24,
                                                        width: 0,
                                                      ),
                                                      Text(getSlowestTime(filterType, filterDistance, filterDateRange),
                                                        style: TextStyle(
                                                            fontSize: (18 / 720) * MediaQuery.of(context).size.height
                                                        ),
                                                      ),
                                                    ]
                                                )
                                            )
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Card(
                                            elevation: 7,
                                            child: Padding(
                                                padding: const EdgeInsets.only(left: 35, right: 35, bottom: 22, top:22),
                                                child: Column(
                                                    children: [
                                                      Text('Total time',
                                                        style: TextStyle(
                                                            fontSize: (19 / 720) * MediaQuery.of(context).size.height,
                                                            fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 24,
                                                        width: 0,
                                                      ),
                                                      Text(getTotalTime(filterType, filterDistance, filterDateRange),
                                                        style: TextStyle(
                                                            fontSize: (18 / 720) * MediaQuery.of(context).size.height
                                                        ),
                                                      ),
                                                    ]
                                                )
                                            )
                                        ),
                                        Card(
                                            elevation: 7,
                                            child: Padding(
                                                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 22, top:22),
                                                child: Column(
                                                    children: [
                                                      Text('Total distance',
                                                        style: TextStyle(
                                                            fontSize: (19 / 720) * MediaQuery.of(context).size.height,
                                                            fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 24,
                                                        width: 0,
                                                      ),
                                                      Text(getTotalDistance(filterType, filterDistance, filterDateRange),
                                                        style: TextStyle(
                                                            fontSize: (18 / 720) * MediaQuery.of(context).size.height
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
                    ),
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
            create: (context) => Time(),
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
                            fontSize: (16 / 720) * MediaQuery.of(context).size.height
                          ),
                        ),
                      ),
                    ]
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<ActivityType>(
                        title: Text('Race',
                        style: TextStyle(
                          fontSize: (15 / 720) * MediaQuery.of(context).size.height,
                        ),
                        ),
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
                        title: Text('Walk',
                        style: TextStyle(
                          fontSize: (15 / 720) * MediaQuery.of(context).size.height
                        )),
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
                          fontSize: (16 / 720) * MediaQuery.of(context).size.height
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
                            fontSize: (16 / 720) * MediaQuery.of(context).size.height
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
                            fontSize: (16 / 720) * MediaQuery.of(context).size.height
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