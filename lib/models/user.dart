class User {

  String username;
  String password;
  String role;
  String name;
  int plafond;
  String eventsReg;
  String cc;
  String office;
  String regDate;


  User({this.username, this.password, this.role, this.name, this.plafond,
  this.eventsReg, this.cc, this.office, this.regDate});

  @override
  String toString() {
    return '$username|$password|$role|$name|$plafond';
  }

  Map toJson() =>  {
    'username': username,
    'password': password,
    'role': role,
    'name': name,
    'pladond': plafond,
    'eventsReg': eventsReg,
    'cc': cc,
    'office': office,
    'regDate': regDate,
  };


  User.fromJson(Map<String, dynamic> json)
      : username = json['username'].toString(),
        password = json['password'].toString(),
        role = json['role'].toString(),
        name = json['name'].toString(),
        plafond = json['plafond'],
        eventsReg = json['eventReg'],
        cc = json['cc'],
        office = json['office'],
        regDate = json['regDate'];
}