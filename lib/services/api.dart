import 'package:projeto_tfc/models/user.dart';
import '../models/event.dart';
import '../models/times.dart';

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
     deadline: '2021-03-01',
     local: 'Lisboa',
     type: '10km',
     cost: 5,
     image: 'assets/images/25abril.jpg',
   ),
   Event(
     name: 'Maratona EDP',
     date: '2021-06-10',
     deadline: '2021-05-15',
     local: 'Lisboa',
     type: 'Maratona',
     cost: 10,
     image: 'assets/images/edp.jpg',
   ),
   Event(
     name: 'São Silvestre Amadora',
     date: '2021-12-31',
     deadline: '2021-12-01',
     local: 'Amadora',
     type: '10km',
     cost: 7,
     image: 'assets/images/saosilvestre.jpg',
   ),
 ];


  List<Event> eventsApprove = [
    Event(
      name: 'III Dualto de Marvila',
      date: '2021-02-26',
      deadline: '2021-01-26',
      local: 'Marvila',
      type: 'Race',
      cost: 10,
    ),
    Event(
      name: 'Trail da Costa Saloia',
      date: '2021-02-14',
      deadline: '2021-01-5',
      local: 'Colares',
      type: 'Walk',
      cost: 3,
    ),

  ];

  List<User> usersApprove = [
    User(
        name: 'António Fonseca',
        cc: '123456789',
        office: 'Porto',
        regDate: '2021-01-17'
    ),
    User(
        name: 'Maria Santos',
        cc: '987654321',
        office: 'Lisboa',
        regDate: '2021-04-21'
    )
  ];

  List<User> usersAuth = [
    User(
        username: 'catarinamoita',
        password: 'qwerty',
        role: 'Administrator',
        name: 'Catarina Moita',
        plafond: 10
    ),
    User(
        username: 'rodrigocorreia',
        password: '1234',
        role: 'Administrator',
        name: 'Rodrigo Corrreia',
        plafond: 50
    ),
    User(
        username: 'teste',
        password: 'teste',
        role: 'Member',
        name: 'Teste',
        plafond: 50
    ),
  ];

}