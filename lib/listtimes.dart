class FinishTime {

  String activityType;
  int distance;
  DateTime dateTime;
  double time;

  FinishTime(this.activityType, this.distance, this.dateTime, this.time);

  static final getTime = [
    {
      'activityType': 'Race',
      'distance': 10,
      'dateTime': '17/01/2020',
      'time': '1:50:0',
    },
    {
      'activityType': 'Race',
      'distance': 12.5,
      'dateTime': '17/02/2020',
      'time': '3:50:0',
    },
    {
      'activityType': 'Race',
      'distance': 42,
      'dateTime': '17/03/2020',
      'time': '7:30:3',
    },
    {
      'activityType': 'Walk',
      'distance': 10,
      'dateTime': '17/04/2020',
      'time': '3:40:0',
    },
    {
      'activityType': 'Walk',
      'distance': 5,
      'dateTime': '17/05/2020',
      'time': '1:20:7',
    },
    {
      'activityType': 'Race',
      'distance': 5,
      'dateTime': '17/06/2020',
      'time': '0:35:0',
    },
    {
      'activityType': 'Race',
      'distance': 10,
      'dateTime': '17/07/2020',
      'time': '1:5:55',
    },
  ];

}