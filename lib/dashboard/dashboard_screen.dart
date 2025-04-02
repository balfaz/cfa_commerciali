import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final List<Map<String, dynamic>> opzioni = [
  {'name': 'Products', 'icon': Icon(Icons.category, size: 30)},
  {'name': 'Orders', 'icon': Icon(Icons.list, size: 30)},
  {'name': 'Cart', 'icon': Icon(Icons.shopping_cart, size: 30)},
];

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Column(children: [searchBar(), grigliOpz()]),
    );
  }

  Widget searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: SizedBox(
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
    );
  }

  Widget grigliOpz() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: opzioni.length,
          itemBuilder: (context, index) {
            return Card(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    opzioni[index]['icon'],
                    Text(
                      '${opzioni[index]['name']}',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
