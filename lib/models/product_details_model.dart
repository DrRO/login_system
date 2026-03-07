class ProductDetailsModel {
  final int id;
  final String title;
  final int price;
  final String description;
  final String image;
  final String category;

  ProductDetailsModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.category,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
      image: json['images'][0],
      category: json['category']['name'],
    );
  }
}