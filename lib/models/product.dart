

class Product {
  int? id;
  String? title;
  double? price;
  String? category;
  String? description;
  String? image;

  Product(
      {this.id,
      this.title,
      this.price,
      this.category,
      this.description,
      this.image});

  factory Product.fromJson(Map<String, dynamic> item) {
    return Product(
      id: int.parse(item['id'].toString()),
      title: item['title'],
      price: double.parse(item['price'].toString()),
      category: item['category'],
      description: item['description'],
      image: item['image'],
    );
  }
}
