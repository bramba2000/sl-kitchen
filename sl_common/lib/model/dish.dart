import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'dish.freezed.dart';
part 'dish.g.dart';

@freezed
class Dish with _$Dish {
  const factory Dish({
    required String name,
    required String description,
    required double price,
    List<String>? addons,
  }) = _Dish;

  factory Dish.fromJson(Map<String, dynamic> json) => _$DishFromJson(json);
}
