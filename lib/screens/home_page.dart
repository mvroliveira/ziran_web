import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZIRAN - MENU'),
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: () => context.go('/')),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Olá, Colaborador",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    const Text("Selecione uma operação abaixo:"),
                    const SizedBox(height: 24),

                    _MenuCard(
                      title: "LER QR CODE",
                      subtitle: "Identificar ponto",
                      icon: Icons.qr_code_scanner,
                      color: Colors.blueGrey.shade900,
                      onTap: () => context.push('/scan'),
                    ),
                    const SizedBox(height: 16),

                    _MenuCard(
                      title: "FILA DE SEPARAÇÃO",
                      subtitle: "Ver pedidos",
                      icon: Icons.assignment_outlined,
                      color: Colors.blueGrey.shade600,
                      onTap: () => context.push('/fila'),
                    ),

                    SizedBox(height: constraints.maxHeight > 500 ? 100 : 20),

                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () => context.push('/dashboard'),
                        icon: const Icon(Icons.dashboard),
                        label: const Text("DASHBOARD GERAL"),
                        style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(16)),
                      ),
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
}

class _MenuCard extends StatelessWidget {
  final String title, subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _MenuCard({required this.title, required this.subtitle, required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: color,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: 32),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 13)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.white54),
            ],
          ),
        ),
      ),
    );
  }
}