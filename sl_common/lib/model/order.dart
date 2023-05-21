import 'package:freezed_annotation/freezed_annotation.dart';
import 'order_status.dart';
import 'dish.dart';

part 'order.freezed.dart';
part 'order.g.dart';

@freezed
class Order with _$Order {
  const Order._();

  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory Order(
      {required List<Dish> dishes,
      required String identifier,
      required OrderStatus status}) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  double get price => dishes.fold(0, (p, d) => p + d.price);
}
