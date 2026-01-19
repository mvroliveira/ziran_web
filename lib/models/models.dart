import 'package:flutter/foundation.dart';

// Estados do pedido conforme pautado no MVP
enum OrderStatus { aberto, emSeparacao, separado, entregue, cancelado }

@immutable
class OrderItem {
  final String sku;
  final String description;
  final int quantity;

  const OrderItem({
    required this.sku,
    required this.description,
    required this.quantity,
  });
}

@immutable
class Order {
  final String id;
  final String pointId;
  final OrderStatus status;
  final List<OrderItem> items;
  final DateTime createdAt;
  final String? assignedTo;

  const Order({
    required this.id,
    required this.pointId,
    required this.status,
    required this.items,
    required this.createdAt,
    this.assignedTo,
  });
  
  Order copyWith({OrderStatus? status, String? assignedTo}) {
    return Order(
      id: id,
      pointId: pointId,
      status: status ?? this.status,
      items: items,
      createdAt: createdAt,
      assignedTo: assignedTo ?? this.assignedTo,
    );
  }
}