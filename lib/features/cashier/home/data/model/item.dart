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

  factory Item.fromJson(Map<String, dynamic> json, String category) {
    return Item(
      id: json['id'] ?? 0, // Provide a default value if id is null
      name: json['name'] ?? 'Unknown', // Default for name
      description: json['description'] ?? '', // Default for description
      price: (json['price'] as num?)?.toDouble() ??
          0.0, // Handle null or invalid price
      imageUrl: json['image_url'] ?? '', // Default for imageUrl
      category: category, // Category from the parameter
    );
  }
}
