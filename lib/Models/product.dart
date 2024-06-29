class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String imagePath;
  final int totalSold;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.totalSold,
  });
}


List<Product> staticProducts = [
  Product(
    id: 1,
    name: 'Rexus Bluetooth Gamepad Gladius GX300',
    description: 'Gamepad Wired',
    price: 599.000,
    imagePath:
        'https://rexus.id/cdn/shop/files/GX300_2_59fcf15d-4843-4136-b52f-cbe75f79d9e4.png',
    totalSold: 100,
  ),
];

List<Product> getProducts() {
  return staticProducts;
}
