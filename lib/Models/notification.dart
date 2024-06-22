class Notification {
  int? id;
  late int userId;
  late String notifikasi;

  Notification({this.id, required this.userId, required this.notifikasi});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    if (id != null) {
      map['id'] = id;
    }
    map['userId'] = userId;
    map['notifikasi'] = notifikasi;
    return map;
  }

  Notification.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    userId = map['userId'];
    notifikasi = map['notifikasi'];
  }
}
