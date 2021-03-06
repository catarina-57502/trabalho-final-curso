class Event {

  final int id;
  final bool approvedP;
  final String name;
  final String location;
  final String date;
  final String dueDate;
  final String url;
  final String activities;
  final String img;
  final int cost;
  final double rating;

  Event({this.id, this.approvedP, this.name, this.location, this.date, this.dueDate, this.url, this.activities, this.img, this.cost, this.rating});


  @override
  String toString() {
    return 'Event{id: $id, approvedP: $approvedP, name: $name, location: $location, date: $date, dueDate: $dueDate, url: $url, activities: $activities, img: $img, cost: $cost, rating: $rating}';
  }

  Event.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        approvedP = json['approvedP'],
        name = json['name'],
        location = json['location'],
        date = json['date'],
        dueDate = json['dueDate'],
        url = json['url'],
        activities = json['activities'],
        img = json['img'],
        cost = json['cost'],
        rating = json['rating'];
}