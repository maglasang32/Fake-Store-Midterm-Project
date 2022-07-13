// ignore_for_file: avoid_print, invalid_return_type_for_catch_error

import 'package:fake_store/models/cart.dart';
import 'package:fake_store/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'https://fakestoreapi.com';
  static const headers = {'Content-type': 'application/json'};

  Future<dynamic> login(String userName, String password) async {
    return http.post(Uri.parse("$baseUrl/auth/login"),
        body: {'username': userName, 'password': password}).then((data) {
      print(data.statusCode);
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return jsonData;
      }
    }).catchError((err) => print(err));
  }

  Future<List<Product>> getAllProducts() async {
    return http.get(Uri.parse('$baseUrl/products')).then((data) {
      final productList = <Product>[];
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        for (var item in jsonData) {
          productList.add(Product.fromJson(item));
        }
      }
      return productList;
    }).catchError((err) => print(err));
  }

  Future<Product> getProduct(String id) async {
    return http.get(Uri.parse('$baseUrl/products/$id')).then((data) {
      var product = Product();
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        product = Product.fromJson(jsonData);
      }
      return product;
    }).catchError((err) => print(err));
  }

  Future<void> updateCart(int cartID, int prodID) {
    final tempCart = Cart(userId: cartID, date: DateTime.now(), products: [
      {'productId': prodID, 'quantity': 1}
    ]);
    return http
        .put(Uri.parse('$baseUrl/carts/$cartID'),
            headers: headers, body: json.encode(tempCart.toJson()))
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        print(jsonData);
      }
    }).catchError((err) => print(err));
  }

  Future<dynamic> getAllCategories() {
    return http.get(Uri.parse("$baseUrl/products/categories")).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return jsonData;
      }
    }).catchError((err) => print(err));
  }

  Future<dynamic> getCategory(String category) {
    return http
        .get(Uri.parse("$baseUrl/products/category/$category"))
        .then((data) {
      var categoryProducts = <Product>[];
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        for (var item in jsonData) {
          categoryProducts.add(Product.fromJson(item));
        }
      }
      return categoryProducts;
    }).catchError((err) => print(err));
  }

  Future<Cart> getCart(String id) async {
    return http.get(Uri.parse('$baseUrl/carts/$id')).then((data) {
      var cart = Cart(date: DateTime.now(), products: [], userId: 1);
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        cart = Cart.fromJson(jsonData);
      }
      return cart;
    }).catchError((err) => print(err));
  }

  Future<void> deleteCart(String id) async {
    return http.delete(Uri.parse('$baseUrl/carts/$id')).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        print(jsonData);
      }
    }).catchError((err) => print(err));
  }
}
