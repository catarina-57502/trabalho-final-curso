class MembersToAprrove {

  String name;
  String cc;
  String office;
  String reg;

  MembersToAprrove(this.name, this.cc, this.office, this.reg);

  MembersToAprrove.fromJson(Map<String, dynamic> json)
      : name = json['name'].toString(),
        cc = json['cc'].toString(),
        office = json['office'].toString(),
        reg = json['reg'].toString();


  static final getMember = [
    {
      'name': 'António Fonseca',
      'CC': '123456789',
      'office': 'Porto',
      'reg': '17/01/2021'
    },
    {
      'name': 'Maria Santos',
      'CC': '987654321',
      'office': 'Lisboa',
      'reg': '04/01/2021'
    },
  ];
}