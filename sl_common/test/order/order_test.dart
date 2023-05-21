import 'package:flutter_test/flutter_test.dart';
import 'package:sl_common/model/order.dart';
import 'package:sl_common/model/order_status.dart';
import 'package:sl_common/model/dish.dart';

void main() {
  group("Basic tests of (de)serialization of order - ", () {
    test("Serialize an order", () {
      const order = Order(
        dishes: [],
        identifier: 'identifier',
        status: OrderStatus.delivered,
      );
      final json = order.toJson();
      expect(json['dishes'], []);
      expect(json['identifier'], 'identifier');
      expect(json['status'], 'delivered');
    });

    test("Deserialize an order", () {
      const json = {
        'dishes': [],
        'identifier': 'identifier',
        'status': 'delivered',
      };
      final order = Order.fromJson(json);
      expect(order.dishes, []);
      expect(order.identifier, 'identifier');
      expect(order.status, OrderStatus.delivered);
    });
  });

  test("Give correct price", () {
    const order = Order(
      dishes: [
        Dish(
          name: 'name1',
          description: 'description1',
          price: 1.0,
          addons: ['addon1', 'addon2'],
        ),
        Dish(
          name: 'name2',
          description: 'description2',
          price: 2.0,
          addons: ['addon3', 'addon4'],
        ),
      ],
      identifier: 'identifier',
      status: OrderStatus.delivered,
    );
    expect(order.price, 3.0);
  });
}
