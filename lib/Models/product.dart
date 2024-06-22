class Product {
  int? id;
  late String name;
  late String description;
  late double price;
  late String imagePath;
  late int totalSold;

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.totalSold,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    if (id != null) {
      map['id'] = id;
    }
    map['name'] = name;
    map['description'] = description;
    map['price'] = price;
    map['imagePath'] = imagePath;
    map['totalSold'] = totalSold;
    return map;
  }

  Product.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    description = map['description'];
    price = map['price'];
    imagePath = map['imagePath'];
    totalSold = map['totalSold'];
  }
}
