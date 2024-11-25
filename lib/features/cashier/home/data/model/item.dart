class Item {
  final int id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;

  Item({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
  });

  // Factory method to create an Item from JSON
  factory Item.fromJson(Map<String, dynamic> json, String category) {
    return Item(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      imageUrl: json['image_url'],
      category: category,
    );
  }
}
