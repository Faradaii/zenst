class NotificationDB {
  int? id;
  late int userId;
  late String notifikasiHead;
  late String notifikasi;

  NotificationDB({this.id, required this.userId, required this.notifikasi, required this.notifikasiHead});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    if (id != null) {
      map['id'] = id;
    }
    map['userId'] = userId;
    map['notifikasi'] = notifikasi;
    map['notifikasiHead'] = notifikasiHead;
    return map;
  }

  NotificationDB.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    userId = map['userId'];
    notifikasi = map['notifikasi'];
    notifikasiHead = map['notifikasiHead'];
  }
}
