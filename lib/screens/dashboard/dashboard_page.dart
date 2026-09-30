import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/order_provider.dart';
import '../../models/models.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(orderListProvider);

    final totalPedidos = orders.length;
    final pendentes = orders.where((o) => o.status == OrderStatus.aberto).length;
    final concluidos = orders.where((o) => o.status == OrderStatus.entregue).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text("DASHBOARD GERAL", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red.shade900,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Indicadores Principais
            Row(
              children: [
                _buildStatCard("ABERTOS", pendentes.toString(), Colors.orange),
                const SizedBox(width: 12),
                _buildStatCard("CONCLUÍDOS", concluidos.toString(), Colors.green),
              ],
            ),
            const SizedBox(height: 12),
            _buildStatCard("TOTAL DO DIA", totalPedidos.toString(), Colors.red.shade900, isFullWidth: true),

            const SizedBox(height: 30),

            // SEÇÃO MIN-MAX
            const Text("ALERTAS DE REPOSIÇÃO (MIN-MAX)",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.red.shade900),
              ),
              child: Column(
                children: [
                  _buildAlertTile("Graxa Industrial", "Atual: 2 kg", "Mínimo: 5 kg"),
                  _buildAlertTile("Luva Vaqueta", "Atual: 10 un", "Mínimo: 50 un"),
                ],
              ),
            ),

            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Pedidos Recentes", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                // BOTÃO ADICIONADO AQUI
                TextButton.icon(
                  onPressed: () => context.push('/history'),
                  icon: Icon(Icons.history, color: Colors.red.shade900),
                  label: Text("Ver Histórico", style: TextStyle(color: Colors.red.shade900)),
                ),
              ],
            ),
            const Divider(),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: orders.length > 5 ? 5 : orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.red.shade900,
                    child: Text(order.pointId[0], style: const TextStyle(color: Colors.white)),
                  ),
                  title: Text("Pedido ${order.id}"),
                  subtitle: Text("Ponto: ${order.pointId}"),
                  trailing: Text(order.status.name.toUpperCase(),
                      style: TextStyle(color: Colors.red.shade900, fontWeight: FontWeight.bold, fontSize: 10)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color, {bool isFullWidth = false}) {
    return Expanded(
      flex: isFullWidth ? 0 : 1,
      child: Container(
        width: isFullWidth ? double.infinity : null,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color, width: 2),
        ),
        child: Column(
          children: [
            Text(value, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: color)),
            Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertTile(String item, String atual, String min) {
    return ListTile(
      leading: const Icon(Icons.warning, color: Colors.red),
      title: Text(item, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text("$atual | $min"),
      trailing: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade900),
        child: const Text("GERAR COMPRA", style: TextStyle(fontSize: 10, color: Colors.white)),
      ),
    );
  }
}