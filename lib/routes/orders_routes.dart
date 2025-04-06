import 'package:cfa_commercial/order/order_screen.dart';
import 'package:go_router/go_router.dart';

List<GoRoute> orderRoutes() {
  return [
    GoRoute(
      path: '/orders',
      builder: (context, state) {
        return const OrderScreen();
      },
    ),
  ];
}
