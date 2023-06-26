import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../model/dish.dart';
import '../api/dish_api.dart';

part 'dish_service.g.dart';

@riverpod
FutureOr<List<Dish>> menuService(
    MenuServiceRef ref, FirebaseFirestore? instance) async {
  final api = DishApi(instance ?? FirebaseFirestore.instance);
  return api.getDishes();
}
