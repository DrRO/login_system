class ProductModel {
  final int id;
  final String title;
  final int price;
  final String image;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      image: json['images'][0],
    );
  }
}