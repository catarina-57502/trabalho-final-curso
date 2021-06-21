import 'dart:convert';

import 'package:projeto_tfc/models/user.dart';
import '../models/event.dart';
import '../models/times.dart';
import 'package:http/http.dart' as http;

// A function that converts a response body into a List<User>.
List<User> parseUsers(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<User>((json) => User.fromJson(json)).toList();
}


Future<List<User>> fetchUsers() async {
  final response = await http.get(Uri.parse('http://192.168.56.1:8080/users/'));
  if (response.statusCode == 200) {
    return parseUsers(response.body);
  } else {
    throw Exception('Failed to load users');
  }
}

// A function that converts a response body into a List<Event>.
List<Event> parseEvents(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Event>((json) => Event.fromJson(json)).toList();
}

Future<List<Event>> fetchEvents() async {
  final response = await http.get(Uri.parse('http://192.168.56.1:8080/events/'));

  if (response.statusCode == 200) {
    return parseEvents(response.body);
  } else {
    throw Exception('Failed to load users');
  }

}


class Api {

 static final Api _instance = Api._internal();

  factory Api() => _instance;

  Api._internal();

 List<FinishTime> userTimes = [FinishTime(
   activityType: 'Race',
   distance: 10,
   dateTime: '2021-01-17',
   time: 1.50,
 ),
   FinishTime(
     activityType: 'Race',
     distance: 12.5,
     dateTime: '2021-01-18',
     time: 3.50,
   ),
   FinishTime(
     activityType: 'Race',
     distance: 42,
     dateTime: '2021-01-19',
     time: 7.30,
   ),
   FinishTime(
     activityType: 'Race',
     distance: 10,
     dateTime: '2021-01-20',
     time: 0.35,
   ),
   FinishTime(
     activityType: 'Walk',
     distance: 7,
     dateTime: '2021-01-21',
     time: 1.27,
   ),
   FinishTime(
     activityType: 'Walk',
     distance: 5,
     dateTime: '2021-01-22',
     time: 3.40,
   ),
 ];

 List<Event> events = [
   Event(
     name: 'Corrida 25 de Abril',
     date: '2021-04-25',
     dueDate: '2021-03-01',
     location: 'Lisboa',
     activities: '10km',
     cost: 5,
     img: '',
     url: 'https://acorrer.pt/eventos/info/2785',
     //rating: 2.0,
   ),
   Event(
     name: 'Maratona EDP',
     date: '2021-06-10',
     dueDate: '2021-05-15',
     location: 'Lisboa',
     activities: 'Maratona',
     cost: 10,
     img: 'assets/images/edp.jpg',
     url: 'http://www.running-portugal.com/lisbon/marathon/en/home.html',
     //rating: 2.0,
   ),
   Event(
     name: 'São Silvestre Amadora',
     date: '2021-12-31',
     dueDate: '2021-12-01',
     location: 'Amadora',
     activities: '10km',
     //cost: 7,
     img: 'assets/images/saosilvestre.jpg',
     url: 'https://www.saosilvestredaamadora.pt/site/',
     //rating: 2.0,
   ),
 ];


  List<Event> eventsApprove = [
    Event(
      name: 'III Dualto de Marvila',
      date: '2021-02-26',
      dueDate: '2021-01-26',
      location: 'Marvila',
      activities: 'Race',
      cost: 10,
      url: 'https://www.federacao-triatlo.pt/ftp2015/events/ii-duatlo-de-marvila/',
      //rating: 2.0,
    ),
    Event(
      name: 'Trail da Costa Saloia',
      date: '2021-02-14',
      dueDate: '2021-01-5',
      location: 'Colares',
      activities: 'Walk',
      cost: 3,
      url: 'https://werun.pt/eventos/trail-da-costa-saloia/',
      //rating: 2.0,
    ),

  ];


  List<User> usersApprove = [
    User(
        name: 'António Fonseca',
      // cc: '123456789',
        office: 'Porto',
      //  regDate: '2021-01-17'
    ),
    User(
        name: 'Maria Santos',
      // cc: '987654321',
        office: 'Lisboa',
      //regDate: '2021-04-21'
    )
  ];

  List<User> usersAuth = [
    User(
        username: 'catarinamoita',
        // password: 'qwerty',
        //  role: 'Administrator',
        name: 'Catarina Moita',
        plafond: 10,
      adminP: true,
    ),
    User(
        username: 'rodrigocorreia',
       // password: '1234',
      //  role: 'Administrator',
        name: 'Rodrigo Corrreia',
        plafond: 50,
      adminP: true,
    ),
    User(
        username: 'teste',
        //password: 'teste',
        //role: 'Member',
        name: 'Teste',
        plafond: 50,
      adminP: false,
    ),
  ];

}