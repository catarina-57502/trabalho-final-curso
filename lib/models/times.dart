import 'package:projeto_tfc/providers/time.dart';

class FinishTime{

  String activityType;
  double distance;
  String dateTime;
  double time;

  FinishTime({this.activityType, this.distance, this.dateTime, this.time});

  Map toJson() =>  {
    'activityType': activityType,
    'distance': distance,
    'dateTime': dateTime,
    'time': time,
  };

  FinishTime.fromJson(Map<String, dynamic> json)
      : activityType = json['activityType'].toString(),
        distance = json['distance'],
        dateTime = json['dateTime'],
        time = json['time'];

  /*
     var response = await client.get('');

    // parse into List
    var parsed = json.decode(response.body) as List<dynamic>;

    // loop and convert each item to Post
    for (var event in parsed) {
      eventsApprove.add(Event.fromJson(event));
    }
     */
}

