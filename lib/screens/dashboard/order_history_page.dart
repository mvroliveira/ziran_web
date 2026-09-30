import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/order_provider.dart';

class OrderHistoryPage extends ConsumerWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(orderListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("HISTÓRICO DE ASSINATURAS"),
        backgroundColor: Colors.red.shade900,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.normal,
        ),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Ordem: ${order.id}", style: const TextStyle(fontWeight: FontWeight.bold)),
                  const Divider(),
                  _buildSignLine("Solicitado por:", order.requestedBy ?? "Sistema"),
                  _buildSignLine("Separado por:", order.pickedBy ?? "Aguardando"),
                  _buildSignLine("Entregue por:", order.deliveredBy ?? "Pendente"),
                  const SizedBox(height: 8),
                  Text("Status: ${order.status.name.toUpperCase()}",
                      style: TextStyle(color: Colors.red.shade900, fontSize: 12)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSignLine(String label, String user) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(user, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}