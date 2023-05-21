import '../model/dish.dart';
import '../model/order.dart';
import '../model/order_status.dart';
import '../api/order_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fs;

class OrderService {
  final OrderApi _api;

  OrderService([fs.FirebaseFirestore? instance])
      : _api = OrderApi(instance ?? fs.FirebaseFirestore.instance);

  Future<List<Order>> get allOrders async => await _api.getOrders();

  Future<List<Order>> get pendingOrders async => (await _api.getOrders())
      .where((o) => o.status == OrderStatus.pending)
      .toList();

  Future<List<Order>> get completedOrders async => (await _api.getOrders())
      .where((o) => o.status == OrderStatus.delivered)
      .toList();

  Future<List<Order>> get rejectedOrders async => (await _api.getOrders())
      .where((o) => o.status == OrderStatus.rejected)
      .toList();

  Future<List<Order>> get payedOrders async => (await _api.getOrders())
      .where((o) => o.status == OrderStatus.payed)
      .toList();

  Future<void> cancelOrder(Order order) async {
    final newOrder = order.copyWith(status: OrderStatus.rejected);
    await _api.updateOrder(order, newOrder);
  }

  Future<void> deliverOrder(Order order) async {
    final newOrder = order.copyWith(status: OrderStatus.delivered);
    await _api.updateOrder(order, newOrder);
  }

  Future<void> payOrder(Order order) async {
    final newOrder = order.copyWith(status: OrderStatus.payed);
    await _api.updateOrder(order, newOrder);
  }

  //TODO: add better default identifier
  Future<void> addOrder(
    List<Dish> dishes, {
    String? identifier,
  }) async {
    final order = Order(
      dishes: dishes,
      identifier: identifier ?? DateTime.now().toString(),
      status: OrderStatus.pending,
    );
    await _api.addOrder(order);
  }
}
