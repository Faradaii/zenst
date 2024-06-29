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

List<Product> products = [
  Product(
    id: 1,
    name: 'Rexus Bluetooth Gamepad Gladius GX300',
    description: 'Gamepad Wired',
    price: 599.000,
    imagePath:
        'https://rexus.id/cdn/shop/files/GX300_2_59fcf15d-4843-4136-b52f-cbe75f79d9e4.png',
    totalSold: 2913,
  ),
  Product(
    id: 2,
    name: 'Fantech RAIGOR Gen III WG12R & WG12RS',
    description: 'Mouse Wireless Gaming',
    price: 195.000,
    imagePath:
        'https://fantech.id/wp-content/uploads/2024/06/Mouse-Gaming-Anti-Brisik-WG12RS-Gabungan-1.jpg',
    totalSold: 5271,
  ),
  Product(
    id: 3,
    name: 'Fantech ATOM PRO83 MK913',
    description: 'Mechanical Keyboard',
    price: 299.000,
    imagePath:
        'https://fantech.id/wp-content/uploads/2024/03/MK913-Gabungan.jpg',
    totalSold: 8294,
  ),
  Product(
    id: 4,
    name: 'Rexus Laptop Stand Decha Frost FP04',
    description: 'Laptop Stand',
    price: 389.000,
    imagePath: 'https://rexus.id/cdn/shop/files/FP04_5.png',
    totalSold: 4723,
  ),
  Product(
    id: 5,
    name: 'KOORUI 27E3QK 240Hz Extremely Smooth Gaming Monitor',
    description: 'Gaming Monitor',
    price: 2929.000,
    imagePath: 'https://www.koorui.net/upload/ztyImg/2023-11/6567292daed45.jpg',
    totalSold: 7812,
  ),
  Product(
    id: 6,
    name: 'Eilik Desktop Companion Bot ',
    description: 'Accessories',
    price: 1289.000,
    imagePath:
        'https://ae01.alicdn.com/kf/Se5cce76101fa4f908dee2186050bbfa0W/Eilik-mainan-elektronik-anak-Robot-Robot-cerdas-interaksi-perasaan-Ai-Puzzle-elektronik-Desktop-pendamping-hewan-peliharaan.jpg',
    totalSold: 10231,
  ),
];

List<Product> getProducts() {
  return products;
}
