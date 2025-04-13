import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderScreen extends ConsumerWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ordini')),
      body: Column(
        children: [
          const Divider(height: 1),
          const SizedBox(child: Text('Orders Screen')),
        ],
      ),
    );
  }

  /*     Future<String> caricaDati {
      final dir =  getApplicationDocumentDirectory();
      final isar =  Isar.open([Prodotto], directory: dir.path);
    } */
}
