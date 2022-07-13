class Cart {
  int? id;
  int userId;
  DateTime date;
  List<dynamic> products;

  Cart({
    this.id,
    required this.userId,
    required this.date,
    required this.products,
  });

  factory Cart.fromJson(Map<String, dynamic> data) {
    return Cart(
      id: int.parse(data['id'].toString()),
      userId: int.parse(data['userId'].toString()),
      date: DateTime.parse(data['date']),
      products: data['products'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'date': date.toIso8601String(),
      'products': products
    };
  }
}
