class ItemModel {
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;

  ItemModel(
      {required this.name,
      required this.category,
      required this.price,
      required this.description,
      required this.imageUrl});

  factory ItemModel.fromJson(Map<String, dynamic> json, String category) {
    return ItemModel(
      name: json['name'] ?? 'Unknown',
      description: json['description'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['image_url'] ?? '',
      category: category,
    );
  }
}
