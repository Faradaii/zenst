class User {
  int? id;
  late String name;
  late String email;
  late String password;

  User({this.id, required this.name, required this.email, required this.password});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    if (id != null) {
      map['id'] = id;
    }
    map['name'] = name;
    map['email'] = email;
    map['password'] = password;
    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    email = map['email'];
    password = map['password'];
  }
}
