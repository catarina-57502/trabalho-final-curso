class User {

  final int id;
  final String username;
  final bool adminP;
  final bool approvedP;
  final int cc;
  final String name;
  final String email;
  final String birthdate;
  final String tshirt;
  final String office;
  final int plafond;
  final String password;


  User({this.id, this.username, this.adminP, this.approvedP, this.cc,
  this.name, this.email, this.birthdate, this.tshirt, this.office, this.plafond, this.password});


  @override
  String toString() {
    return 'User{id: $id, username: $username, adminP: $adminP, approvedP: $approvedP, cc: $cc, name: $name, email: $email, birthdate: $birthdate, tshirt: $tshirt, office: $office, plafond: $plafond, password: $password}';
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      adminP: json['adminP'],
      approvedP: json['approvedP'],
      cc: json['cc'],
      name: json['name'],
      email: json['email'],
      birthdate: json['birthdate'],
      tshirt: json['tshirt'],
      office: json['office'],
      plafond: json['plafond'],
      password: json['password']
    );
  }
}