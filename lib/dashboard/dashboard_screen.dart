import 'package:cfa_commercial/custom_theme/widget_custom_color.dart';
import 'package:cfa_commercial/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Column(
        children: [
          Expanded(flex: 1, child: searchBar()),
          Expanded(flex: 1, child: grigliOpz(ref)),
          Divider(height: 1),
          Expanded(flex: 5, child: tabsDashboard()),
        ],
      ),
    );
  }

  Widget searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 4,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cerca...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorBckGIconButton,
              ),
              child: IconButton(
                onPressed: () {
                  // Action for the button
                },
                icon: const Icon(Icons.qr_code, color: colorIconButton),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget grigliOpz(WidgetRef ref) {
    final appRoute = ref.watch(appRouterProvider);
    final List<Map<String, dynamic>> opzioni = [
      {
        'name': 'Products',
        'icon': Icon(Icons.category, size: 30, color: Colors.blue),
        'action': () => appRoute.push('/catalog'),
      },
      {
        'name': 'Orders',
        'icon': Icon(Icons.list, size: 30),
        'action': () => appRoute.push('/orders'),
      },
      {
        'name': 'Cart',
        'icon': Icon(Icons.shopping_cart, size: 30, color: Colors.green),
        'action': () => print('Cart'),
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.5,
          crossAxisSpacing: 6,
          mainAxisSpacing: 10,
        ),
        itemCount: opzioni.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              if (opzioni[index]['action'] != null) {
                opzioni[index]['action']();
              }
            },
            child: Card(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    opzioni[index]['icon'],
                    Text(
                      '${opzioni[index]['name']}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget tabsDashboard() {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Column(
        children: [
          const TabBar(
            tabs: [Tab(text: 'Prodotti Recenti'), Tab(text: 'Ordini Recenti')],
          ),
          Expanded(
            child: TabBarView(
              children: [
                Center(child: Text('Prodotti Tab')),
                Center(child: Text('Orders Tab')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
