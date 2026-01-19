import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/models.dart';

/// Provider que expõe a lista de pedidos para todo o app
final orderListProvider = StateNotifierProvider<OrderNotifier, List<Order>>((ref) {
  return OrderNotifier();
});

class OrderNotifier extends StateNotifier<List<Order>> {
  OrderNotifier() : super([]);

  /// Cria um novo pedido (chamado na tela de confirmação do ponto)
  void addOrder(Order order) {
    state = [...state, order];
  }

  /// Muda o status do pedido (ex: ABERTO -> EM_SEPARACAO)
  /// Isso vai atualizar automaticamente a tela do Separador e do Coordenador
  void updateOrderStatus(String orderId, OrderStatus newStatus, {String? user}) {
    state = [
      for (final order in state)
        if (order.id == orderId)
          order.copyWith(
            status: newStatus,
            assignedTo: user ?? order.assignedTo,
          )
        else
          order,
    ];
  }

  List<Order> getOrdersByStatus(OrderStatus status) {
    return state.where((order) => order.status == status).toList();
  }
}