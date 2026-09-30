import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/auth/login_page.dart';
import '../screens/dashboard/dashboard_page.dart';
import '../screens/dashboard/order_history_page.dart';
import '../screens/fila/order_fila_page.dart';
import '../screens/home/home_page.dart';
import '../screens/point/point_page.dart';
import '../screens/scanner/qr_scan_page.dart';


final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginPage(),
    ),

    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),

    GoRoute(
      path: '/scan',
      builder: (context, state) => const QrScanPage(),
    ),

    GoRoute(
      path: '/point/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return PointPage(pointId: id);
      },
    ),

    GoRoute(
      path: '/fila',
      builder: (context, state) => const OrderFilaPage(),
    ),

    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardPage(),
    ),

    GoRoute(
      path: '/history',
      builder: (context, state) => const OrderHistoryPage(),
    ),
  ],
);