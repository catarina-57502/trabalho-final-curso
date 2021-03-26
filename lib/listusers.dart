class Users {

  String username;
  String password;
  String role;
  String name;

  Users(this.username, this.password, this.role, this.name);

  @override
  String toString() {
    return '$username|$password|$role|$name';
  }

  Users.fromJson(Map<String, dynamic> json)
      : username = json['username'].toString(),
        password = json['password'].toString(),
        role = json['role'].toString(),
        name = json['name'].toString();

  static final getUsers = [
    {
      'username': 'catarinamoita',
      'password': 'qwerty',
      'role': 'Administrator',
      'name': 'Catarina Moita',
      'inscricoes': "",
    },
    {
      'username': 'rodrigocorreia',
      'password': '1234',
      'role': 'Administrator',
      'name': 'Rodrigo Corrreia',
      'inscricoes': "",
    },
    {
      'username': 'teste',
      'password': 'teste',
      'role': 'Member',
      'name': 'Teste',
      'inscricoes': "",
    }
  ];


}