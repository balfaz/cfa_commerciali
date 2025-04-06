import 'package:cfa_commercial/products/catalog_screen.dart';
import 'package:go_router/go_router.dart';

List<GoRoute> productRoutes() {
  return [
    GoRoute(
      path: '/catalog',
      builder: (context, state) {
        return const CatalogScreen();
      },
    ),
  ];
}
