import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/models.dart';
import '../../providers/order_provider.dart';

class PointPage extends ConsumerStatefulWidget {
  final String pointId;

  const PointPage({super.key, required this.pointId});

  @override
  ConsumerState<PointPage> createState() => _PointPageState();
}

class _PointPageState extends ConsumerState<PointPage> {
  final Map<String, int> _cart = {};

  // Banco de dados fake organizado por Ponto (ID do QR Code)
  final Map<String, List<Consumable>> _estoquePorPonto = {
    'MANUTENCAO_1': [
      const Consumable(id: 'm1_1', sku: 'GR-001', description: 'Graxa Industrial 500g'),
      const Consumable(id: 'm1_2', sku: 'WD-003', description: 'Desengripante WD-40'),
    ],
    'MANUTENCAO_2': [
      const Consumable(id: 'm2_1', sku: 'RL-6204', description: 'Rolamento 6204 ZZ'),
      const Consumable(id: 'm2_2', sku: 'RT-05', description: 'Retentor de Óleo'),
    ],
    'KANBAN': [
      const Consumable(id: 'k1', sku: 'LV-002', description: 'Luva de Vaqueta (Par)'),
      const Consumable(id: 'k2', sku: 'OC-001', description: 'Óculos de Proteção'),
      const Consumable(id: 'k3', sku: 'MS-001', description: 'Máscara PFF2'),
    ],
  };

  void _updateQuantity(String id, int delta) {
    setState(() {
      final current = _cart[id] ?? 0;
      final newValue = current + delta;
      if (newValue >= 0) {
        _cart[id] = newValue;
      }
    });
  }

  void _confirmarPedido(List<Consumable> produtosDisponiveis) {
    // 1. Mapeia o que está no carrinho para itens do pedido
    final items = _cart.entries
        .where((e) => e.value > 0)
        .map((e) {
      final p = produtosDisponiveis.firstWhere((item) => item.id == e.key);
      return OrderItem(sku: p.sku, description: p.description, quantity: e.value);
    }).toList();

    // 2. Cria o pedido
    final newOrder = Order(
      id: "OR-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}",
      pointId: widget.pointId,
      status: OrderStatus.aberto,
      items: items,
      createdAt: DateTime.now(),
    );

    // 3. Salva no Provider global (Riverpod)
    ref.read(orderListProvider.notifier).addOrder(newOrder);

    // 4. Feedback e navegação
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Pedido ${newOrder.id} enviado para a Fila!"),
        backgroundColor: Colors.green,
      ),
    );
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    // Identifica quais produtos mostrar baseado no QR Code lido
    final produtosVisiveis = _estoquePorPonto[widget.pointId] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text("Ponto: ${widget.pointId}"),
        backgroundColor: Colors.red.shade900,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: produtosVisiveis.isEmpty
          ? _buildErroPonto()
          : Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: produtosVisiveis.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final item = produtosVisiveis[index];
                final qty = _cart[item.id] ?? 0;

                return ListTile(
                  title: Text(item.description, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("SKU: ${item.sku}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove_circle, color: Colors.red.shade900),
                        onPressed: () => _updateQuantity(item.id, -1),
                      ),
                      Text(qty.toString(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: Icon(Icons.add_circle, color: Colors.red.shade900),
                        onPressed: () => _updateQuantity(item.id, 1),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          _buildBotaoConfirmar(produtosVisiveis),
        ],
      ),
    );
  }

  Widget _buildErroPonto() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 60, color: Colors.grey),
          const SizedBox(height: 16),
          Text("Ponto '${widget.pointId}' não cadastrado."),
          TextButton(onPressed: () => context.pop(), child: const Text("VOLTAR")),
        ],
      ),
    );
  }

  Widget _buildBotaoConfirmar(List<Consumable> produtos) {
    final temItens = _cart.values.any((v) => v > 0);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2))],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade900,
              disabledBackgroundColor: Colors.grey.shade300,
            ),
            onPressed: temItens ? () => _confirmarPedido(produtos) : null,
            child: const Text("CONFIRMAR REPOSIÇÃO",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}