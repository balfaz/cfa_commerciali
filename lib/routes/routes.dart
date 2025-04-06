import 'package:cfa_commercial/dashboard/dashboard_screen.dart';
import 'package:cfa_commercial/routes/orders_routes.dart';
import 'package:cfa_commercial/routes/products_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();
  return GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      //Todo: implementare inizio navigazione con login
      GoRoute(path: '/', builder: (context, state) => const DashboardScreen()),
      ...productRoutes(),
      ...orderRoutes(),
    ],
  );
});
