import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/messages.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Messages.appName, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.red.shade900,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () => context.go('/'),
          ),
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
                    Text(Messages.tr('home_welcome'),
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    Text(Messages.tr('home_subtitle')),
                    const SizedBox(height: 24),

                    _MenuCard(
                      title: Messages.tr('home_btn_scan'),
                      subtitle: Messages.tr('home_sub_scan'),
                      icon: Icons.qr_code_scanner,
                      color: Colors.red.shade900,
                      onTap: () => context.push('/scan'),
                    ),
                    const SizedBox(height: 16),

                    _MenuCard(
                      title: Messages.tr('home_btn_fila'),
                      subtitle: Messages.tr('home_sub_fila'),
                      icon: Icons.assignment_outlined,
                      color: Colors.red.shade900,
                      onTap: () => context.push('/fila'),
                    ),

                    SizedBox(height: constraints.maxHeight > 500 ? 100 : 20),

                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () => context.push('/dashboard'),
                        icon: const Icon(Icons.dashboard),
                        label: Text(Messages.tr('home_btn_dashboard')),
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