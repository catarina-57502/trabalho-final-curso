class Users {

  String username;
  String password;
  String role;
  String name;
  int plafond;

  Users(this.username, this.password, this.role, this.name, this.plafond);

  @override
  String toString() {
    return '$username|$password|$role|$name|$plafond';
  }

  Users.fromJson(Map<String, dynamic> json)
      : username = json['username'].toString(),
        password = json['password'].toString(),
        role = json['role'].toString(),
        name = json['name'].toString(),
        plafond = json['plafond'];

  static final getUsers = [
    {
      'username': 'catarinamoita',
      'password': 'qwerty',
      'role': 'Administrator',
      'name': 'Catarina Moita',
      'inscricoes': "",
      'plafond': 20
    },
    {
      'username': 'rodrigocorreia',
      'password': '1234',
      'role': 'Administrator',
      'name': 'Rodrigo Corrreia',
      'inscricoes': "",
      'plafond': 50
    },
    {
      'username': 'teste',
      'password': 'teste',
      'role': 'Member',
      'name': 'Teste',
      'inscricoes': "",
      'plafond': 50
    }
  ];


}