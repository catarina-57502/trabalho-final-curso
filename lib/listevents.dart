class Events {

  String name;
  String date;
  String deadline;
  String local;
  String type;
  int cost;


  Events.fromJson(Map<String, dynamic> json)
      : name = json['name'].toString(),
        date = json['date'].toString(),
        deadline = json['dealine'].toString(),
        local = json['local'].toString(),
        type = json['type'].toString(),
        cost = json['cost'];

  static final getEvents = [
    {
      'name': 'Corrida 25 de Abril',
      'date': '25/04/2021',
      'deadline': '1/03/2021',
      'local': 'Lisboa',
      'type': '10km',
      'cost': 5,
      'image': 'assets/images/25abril.jpg'

    },
    {
      'name': 'Maratona EDP',
      'date': '10/05/2021',
      'deadline': '15/04/2021',
      'local': 'Lisboa',
      'type': 'Maratona',
      'cost': 10,
      'image': 'assets/images/edp.jpg',

    },
    {
      'name': 'São Silvestre Amadora',
      'date': '31/12/2021',
      'deadline': '1/12/2021',
      'local': 'Amadora',
      'type': '10km',
      'cost': 7,
      'image': 'assets/images/saosilvestre.jpg',
    },
  ];


}