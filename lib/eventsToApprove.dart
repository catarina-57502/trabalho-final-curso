class EventsToAprrove {

  String name;
  String date;
  String deadline;
  String local;
  String type;
  String cost;

  EventsToAprrove(
      this.name, this.date, this.deadline, this.local, this.type, this.cost);

  EventsToAprrove.fromJson(Map<String, dynamic> json)
      : name = json['name'].toString(),
        date = json['date'].toString(),
        deadline = json['deadline'].toString(),
        local = json['local'].toString(),
        type = json['type'].toString(),
        cost = json['cost'].toString();


  static final getEvents = [
    {
      'name': 'III Dualto de Marvila',
      'date': '26/02/2021',
      'deadline': '26/01/2021',
      'local': 'Marvila',
      'type': 'Duatlo',
      'cost': '10€'
    },
    {
      'name': 'Trail da Costa Saloia',
      'date': '14/03/2021',
      'deadline': '14/02/2021',
      'local': 'Colares',
      'type': 'Caminhada',
      'cost': '3€'
    },
  ];
}