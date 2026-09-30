import 'package:flutter/foundation.dart';

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
class Consumable {
  final String id;
  final String sku;
  final String description;
  final int quantity;

  const Consumable({
    required this.id,
    required this.sku,
    required this.description,
    this.quantity = 0,
  });
}

@immutable
class Order {
  final String id;
  final String pointId;
  final OrderStatus status;
  final List<OrderItem> items;
  final DateTime createdAt;
  final String? requestedBy;
  final String? pickedBy;
  final String? deliveredBy;

  const Order({
    required this.id,
    required this.pointId,
    required this.status,
    required this.items,
    required this.createdAt,
    this.requestedBy,
    this.pickedBy,
    this.deliveredBy,
  });

  Order copyWith({
    OrderStatus? status,
    String? pickedBy,
    String? deliveredBy
  }) {
    return Order(
      id: id,
      pointId: pointId,
      status: status ?? this.status,
      items: items,
      createdAt: createdAt,
      requestedBy: requestedBy,
      pickedBy: pickedBy ?? this.pickedBy,
      deliveredBy: deliveredBy ?? this.deliveredBy,
    );
  }
}