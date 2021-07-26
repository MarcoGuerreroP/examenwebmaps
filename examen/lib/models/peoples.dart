class Peoples {
  int id;
  String nameuser;
  String state;
  String country;
  String gener;

  Peoples({this.id, this.nameuser, this.state, this.country, this.gener});

  Peoples.map(dynamic obj) {
    this.id = obj['id'];
    this.nameuser = obj['nameuser'];
    this.state = obj['state'];
    this.country = obj['country'];
    this.gener = obj['gener'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map["id"] = id;
    map["nameuser"] = nameuser;
    map["state"] = state;
    map["country"] = country;
    map["gener"] = gener;
    return map;
  }
}
