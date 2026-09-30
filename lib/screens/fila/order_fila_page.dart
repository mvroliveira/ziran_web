import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/models.dart';
import '../../providers/order_provider.dart';


class OrderFilaPage extends ConsumerWidget {
  const OrderFilaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(orderListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Fila de Separação"),
        centerTitle: true,
      ),
      body: orders.isEmpty
          ? const Center(child: Text("Nenhum pedido na fila"))
          : ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ExpansionTile(
              leading: _getStatusIcon(order.status),
              title: Text("Pedido: ${order.id}"),
              subtitle: Text("Ponto: ${order.pointId} • Status: ${order.status.name.toUpperCase()}"),
              children: [
                ...order.items.map((item) => ListTile(
                  title: Text(item.description),
                  trailing: Text("Qtd: ${item.quantity}"),
                )),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (order.status == OrderStatus.aberto)
                        ElevatedButton(
                          onPressed: () => ref
                              .read(orderListProvider.notifier)
                              .updateOrderStatus(order.id, OrderStatus.emSeparacao),
                          child: const Text("ASSUMIR"),
                        ),
                      if (order.status == OrderStatus.emSeparacao)
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                          onPressed: () => ref
                              .read(orderListProvider.notifier)
                              .updateOrderStatus(order.id, OrderStatus.separado),
                          child: const Text("MARCAR COMO SEPARADO", style: TextStyle(color: Colors.white)),
                        ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _getStatusIcon(OrderStatus status) {
    switch (status) {
      case OrderStatus.aberto: return const Icon(Icons.fiber_new, color: Colors.blue);
      case OrderStatus.emSeparacao: return const Icon(Icons.pending, color: Colors.orange);
      case OrderStatus.separado: return const Icon(Icons.check_circle, color: Colors.green);
      default: return const Icon(Icons.help_outline);
    }
  }
}