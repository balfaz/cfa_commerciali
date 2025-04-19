import 'dart:convert';

import 'package:cfa_commercial/data/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CatalogScreen extends ConsumerWidget {
  const CatalogScreen({super.key});

  Future<List<dynamic>> loadJsonProducts() async {
    final String stringListProducts = await rootBundle.loadString(
      'assets/articoli.json',
    );
    final List<dynamic> jsonList = json.decode(stringListProducts);
    return jsonList;
    //.map((item) => Product.fromMap(item)).toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final List<Product> listProducts = loadJsonProducts();
    return Scaffold(
      appBar: AppBar(title: const Text('Catalog')),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            const Divider(height: 1),
            const SizedBox(child: Text('Catalog Screen')),
            // Add your catalog items here
            FutureBuilder(
              future: loadJsonProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                List products = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 17, // Example item count
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4,
                      ),
                      child: Card(
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Product: ${products[index]['codice']}'),
                              Text(
                                'Price: ${products[index]['listino2']}',
                                style: TextStyle(
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('${products[index]['descrizione']}'),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
