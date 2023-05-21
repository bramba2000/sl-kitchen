import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/dish.dart';

class DishApi {
  static const _collectionPath = 'dishes';

  DishApi([FirebaseFirestore? instance])
      : _instance = instance ?? FirebaseFirestore.instance;

  final FirebaseFirestore _instance;
  final Map<String, Dish> _cache = HashMap();

  String _getIdByName(Dish previous) =>
      _cache.entries.firstWhere((e) => e.value == previous).key;

  Future<List<Dish>> getDishes({bool useCache = false}) async {
    if (useCache && _cache.isNotEmpty) {
      return _cache.values.toList();
    }
    final snapshot = await _instance.collection(_collectionPath).get();
    _cache.clear();
    _cache.addEntries(snapshot.docs
        .map((doc) => MapEntry(doc.id, Dish.fromJson(doc.data()))));
    return _cache.values.toList();
  }

  Future<Dish> getDish(String name, {bool useCache = false}) async {
    if (useCache && _cache.isNotEmpty) {
      return _cache.values.firstWhere((e) => e.name == name);
    }
    final snapshot = await _instance
        .collection(_collectionPath)
        .where('name', isEqualTo: name)
        .get();
    final result = snapshot.docs.single;
    _cache[result.id] = Dish.fromJson(result.data());
    return _cache[result.id]!;
  }

  Future<void> addDish(Dish dish) async {
    final result =
        await _instance.collection(_collectionPath).add(dish.toJson());
    _cache[result.id] = dish;
  }

  Future<void> updateDish(Dish previous, Dish dish) async {
    if (!_cache.containsValue(previous)) {
      throw ArgumentError('Cannot update dish that does not exist');
    }
    final id = _getIdByName(previous);
    _cache[id] = dish;
    await _instance.collection(_collectionPath).doc(id).update(dish.toJson());
  }

  Future<void> deleteDish(Dish dish) async {
    final id = _getIdByName(dish);
    await _instance.collection(_collectionPath).doc(id).delete();
    _cache.remove(id);
  }
}
