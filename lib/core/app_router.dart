import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/login_page.dart';
import '../screens/home_page.dart';


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
      builder: (context, state) => const Placeholder(
        child: Center(child: Text('Câmera para ler QR Code')),
      ),
    ),

    GoRoute(
      path: '/point/:id',
      builder: (context, state) {
        final pointId = state.pathParameters['id'] ?? 'desconhecido';
        return Placeholder(
          child: Center(child: Text('Ponto: $pointId - Lista de Consumíveis')),
        );
      },
    ),

    GoRoute(
      path: '/fila',
      builder: (context, state) => const Placeholder(
        child: Center(child: Text('Fila de Pedidos para o Separador')),
      ),
    ),

    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const Placeholder(
        child: Center(child: Text('Dashboard de Coordenação')),
      ),
    ),
  ],
);