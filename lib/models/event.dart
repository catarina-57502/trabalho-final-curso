class Event {

  String name;
  String date;
  String deadline;
  String local;
  String type;
  int cost;
  String image;
  String link;
  double rating;


  Event({this.name, this.date, this.deadline, this.local, this.type, this.cost, this.image, this.link, this.rating});

  Map toJson() =>  {
    'name': name,
    'date': date,
    'deadline': deadline,
    'local': local,
    'type': type,
    'cost': cost,
    'image': image,
    'link': link,
    'rating': rating
  };

  Event.fromJson(Map<String, dynamic> json)
      : name = json['name'].toString(),
        date = json['date'].toString(),
        deadline = json['dealine'].toString(),
        local = json['local'].toString(),
        type = json['type'].toString(),
        cost = json['cost'],
        image = json['image'].toString(),
        link = json['link'].toString(),
        rating = json['rating'];

}