import '../model/order.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fs;

class OrderApi {
  static const String _collectionPath = 'orders';
  static const String _statsPath = '--stats--';
  static const String _orderCountField = 'orderCount';

  OrderApi([fs.FirebaseFirestore? instance])
      : _instance = instance ?? fs.FirebaseFirestore.instance {
    _statsDocument = _instance.collection(_collectionPath).doc(_statsPath);
  }

  final fs.FirebaseFirestore _instance;
  late final fs.DocumentReference<Map<String, dynamic>> _statsDocument;
  final Map<String, Order> _cache = {};

  String _getIdByIdentifier(Order previous) =>
      _cache.entries.firstWhere((e) => e.value == previous).key;

  Future<List<Order>> getOrders({bool useCache = false}) async {
    if (useCache && _cache.isNotEmpty) {
      return _cache.values.toList();
    }
    final snapshot = await _instance.collection(_collectionPath).get();
    _cache.clear();
    _cache.addEntries(snapshot.docs
        .map((doc) => MapEntry(doc.id, Order.fromJson(doc.data()))));
    return _cache.values.toList();
  }

  Future<Order> getOrder(String identifier, {bool useCache = false}) async {
    if (useCache && _cache.isNotEmpty) {
      return _cache.values.firstWhere((e) => e.identifier == identifier);
    }
    final snapshot = await _instance
        .collection(_collectionPath)
        .where('identifier', isEqualTo: identifier)
        .get();
    final result = snapshot.docs.single;
    _cache[result.id] = Order.fromJson(result.data());
    return _cache[result.id]!;
  }

  Future<void> addOrder(Order order) async {
    final reference = _instance.collection(_collectionPath).doc();
    await _instance.runTransaction<int>((transaction) async {
      final response = await transaction.get(_statsDocument);
      final count = (response.data()?[_orderCountField] ?? 0) + 1;
      transaction.set(_statsDocument, {_orderCountField: count},
          fs.SetOptions(merge: true));
      transaction.set(
        reference,
        order.identifier.isNotEmpty
            ? order.toJson()
            : order.copyWith(identifier: count.toString()).toJson(),
      );
      return count;
    });
    _cache[reference.id] = order;
  }

  Future<void> updateOrder(Order previous, Order order) async {
    if (!_cache.containsValue(previous)) {
      throw ArgumentError('Cannot update order that does not exist');
    }
    final id = _getIdByIdentifier(previous);
    _cache[id] = order;
    await _instance.collection(_collectionPath).doc(id).update(order.toJson());
  }

  Future<void> deleteOrder(Order order) async {
    final id = _getIdByIdentifier(order);
    await _instance.collection(_collectionPath).doc(id).delete();
    _cache.remove(id);
  }
}
