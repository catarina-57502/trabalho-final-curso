class Events {

  String name;
  String date;

  Events(this.name, this.date);

  Events.fromJson(Map<String, dynamic> json)
      : name = json['name'].toString(),
        date = json['date'].toString();

  static final getEvents = [
    {
      'name': 'Corrida 25 de Abril',
      'date': '25/04/2021',
      'image': 'assets/images/25abril.jpg',

    },
    {
      'name': 'Maratona EDP',
      'date': '10/05/2021',
      'image': 'assets/images/edp.jpg',

    },
    {
      'name': 'São Silvestre Amadora',
      'date': '31/12/2021',
      'image': 'assets/images/saosilvestre.jpg',

    },
  ];
}