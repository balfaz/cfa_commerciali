import 'dart:convert';

import 'package:cfa_commercial/data/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CatalogScreen extends ConsumerWidget {
  const CatalogScreen({super.key});

  Future<List<Product>> loadJsonProducts() async {
    final String stringListProducts = await rootBundle.loadString(
      'assets/products.json',
    );
    final List<dynamic> jsonList = json.decode(stringListProducts);
    return jsonList.map((item) => Product.fromMap(item)).toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Catalog')),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            const Divider(height: 1),
            const SizedBox(child: Text('Catalog Screen')),
            // Add your catalog items here
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 20, // Example item count
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Product $index'),
                  subtitle: Text('Description of Product $index'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
