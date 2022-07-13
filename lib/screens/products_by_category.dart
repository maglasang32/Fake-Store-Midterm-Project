import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../models/product.dart';
import '../services/api_service.dart';
import 'product_detail.dart';

class ProductsByCategoryScreen extends StatelessWidget {
  const ProductsByCategoryScreen({Key? key, required this.categoryName})
      : super(key: key);

  final String categoryName;

  ApiService get service => GetIt.I<ApiService>();

  Future<List<Product>> getProductsByCategory(String categoryName) async {
    final result = await service.getCategory(categoryName);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder(
        future: getProductsByCategory(categoryName),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final products = snapshot.data!;

          return ListView.separated(
            separatorBuilder: (_, __) => const Divider(thickness: 1),
            itemCount: products.length,
            itemBuilder: ((context, index) {
              final product = snapshot.data![index];
              return ListTile(
                title: Text(product.title!),
                leading: Image.network(
                  product.image!,
                  height: 50,
                  width: 50,
                ),
                subtitle: Text('\$${product.price}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetailScreen(id: product.id!),
                    ),
                  );
                },
              );
            }),
          );
        },
      ),
    );
  }
}
