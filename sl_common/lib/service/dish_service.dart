import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/dish.dart';
import '../api/dish_api.dart';

class DishService {
  final DishApi _api;

  DishService([FirebaseFirestore? instance])
      : _api = DishApi(instance ?? FirebaseFirestore.instance);

  Future<List<Dish>> get menu async => await _api.getDishes();
}
