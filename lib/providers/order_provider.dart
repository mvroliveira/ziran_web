import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/models.dart';

/// Provider que expõe a lista de pedidos para todo o app
final orderListProvider = StateNotifierProvider<OrderNotifier, List<Order>>((ref) {
  return OrderNotifier();
});

class OrderNotifier extends StateNotifier<List<Order>> {
  OrderNotifier() : super([]);

  void addOrder(Order order) {
    state = [...state, order];
    // Aqui você poderia disparar uma verificação Min-Max inicial
  }

  /// Atualiza o status e registra a "assinatura digital" (matrícula do usuário)
  void updateOrderStatus(String orderId, OrderStatus newStatus, {String? matricula}) {
    state = [
      for (final order in state)
        if (order.id == orderId)
          _applyTransition(order, newStatus, matricula)
        else
          order,
    ];
  }

  /// Lógica sênior para gerenciar quem assina o quê em cada etapa
  Order _applyTransition(Order order, OrderStatus newStatus, String? matricula) {
    switch (newStatus) {
      case OrderStatus.emSeparacao:
      // Assinatura de quem assumiu a separação (Pick Slip gerado)
        return order.copyWith(status: newStatus, pickedBy: matricula);
      case OrderStatus.entregue:
      // Assinatura de quem confirmou a entrega no ponto (Transação final)
        return order.copyWith(status: newStatus, deliveredBy: matricula);
      default:
        return order.copyWith(status: newStatus);
    }
  }

  // Simulação de Alerta Min-Max
  List<String> checkInventoryAlerts(List<Consumable> currentStock) {
    const int minLevel = 5;
    return currentStock
        .where((item) => item.quantity <= minLevel)
        .map((item) => "ALERTA: ${item.description} abaixo do estoque mínimo!")
        .toList();
  }
}