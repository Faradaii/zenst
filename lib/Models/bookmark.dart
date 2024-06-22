class Bookmark {
  int? id;
  late int userId;
  late String imagePath;

  Bookmark({this.id, required this.userId, required this.imagePath});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    if (id != null) {
      map['id'] = id;
    }
    map['userId'] = userId;
    map['imagePath'] = imagePath;
    return map;
  }

  Bookmark.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    userId = map['userId'];
    imagePath = map['imagePath'];
  }
}
