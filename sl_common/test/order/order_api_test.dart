import 'package:flutter_test/flutter_test.dart';
import 'package:sl_common/api/order_api.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:sl_common/model/dish.dart';
import 'package:sl_common/model/order.dart';
import 'package:sl_common/model/order_status.dart';

void main() {
  group("Test API of orders - ", () {
    late FakeFirebaseFirestore fakeInstance;
    late OrderApi api;

    setUp(() async {
      fakeInstance = FakeFirebaseFirestore();
      api = OrderApi(fakeInstance);
    });

    test("Test creation of a order", () async {
      const order = Order(
          identifier: 'identifier',
          status: OrderStatus.delivered,
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
          ]);
      await api.addOrder(order);
      expect((await fakeInstance.collection('orders').get()).size, isNonZero);
      Order result = Order.fromJson((await fakeInstance
              .collection('orders')
              .where('identifier', isEqualTo: 'identifier')
              .get())
          .docs
          .first
          .data());
      expect(result, isNotNull);
      expect(result.identifier, 'identifier');
      expect(result.status, OrderStatus.delivered);
      expect(result.dishes, order.dishes);
    });

    test("Test retrieving an order", () async {
      const order = Order(
          identifier: 'identifier',
          status: OrderStatus.delivered,
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
          ]);
      await fakeInstance.collection('orders').add(order.toJson());
      await expectLater(api.getOrder('identifier', useCache: true),
          completion(equals(order)));
      await expectLater(api.getOrder('identifier'), completion(equals(order)));
      await expectLater(api.getOrder('identifier', useCache: true),
          completion(equals(order)));
    });

    test("Test retrieving multiple orders", () {
      const orders = [
        Order(
            identifier: 'identifier1',
            status: OrderStatus.delivered,
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
            ]),
        Order(identifier: 'identifier2', status: OrderStatus.pending, dishes: [
          Dish(
            name: 'name3',
            description: 'description3',
            price: 3.0,
            addons: ['addon5', 'addon6'],
          ),
          Dish(
            name: 'name4',
            description: 'description4',
            price: 4.0,
            addons: ['addon7', 'addon8'],
          ),
        ]),
      ];
      for (var order in orders) {
        fakeInstance.collection('orders').add(order.toJson());
      }
      expect(api.getOrders(useCache: true), completion(containsAll(orders)));
    });

    test("Test retrieve a non existing Order", () async {
      await expectLater(api.getOrder('name'), throwsStateError);
    });

    test("Test delete a Order", () async {
      const order = Order(
          identifier: 'identifier',
          status: OrderStatus.delivered,
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
          ]);
      await fakeInstance.collection('orders').add(order.toJson());
      await api.getOrders();
      await api.deleteOrder(order);
      expect(api.getOrders(useCache: true), completion(isEmpty));
      expect((await fakeInstance.collection('orders').get()).docs, isEmpty);
    });

    tearDown(() {
      print(fakeInstance.dump());
    });

    test("Test delete a Order not present", () async {
      const order = Order(
          identifier: 'identifier',
          status: OrderStatus.delivered,
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
          ]);
      await expectLater(api.deleteOrder(order), throwsStateError);
    });

    test("Test update of an order", () async {
      const order = Order(
          identifier: 'identifier',
          status: OrderStatus.delivered,
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
          ]);
      final updatedOrder = order.copyWith(status: OrderStatus.pending);
      await api.addOrder(order);
      await api.updateOrder(order, updatedOrder);
      expect((await fakeInstance.collection('orders').get()).docs.length, 2);
      final result = Order.fromJson((await fakeInstance
              .collection('orders')
              .where('identifier', isEqualTo: 'identifier')
              .get())
          .docs
          .first
          .data());
      expect(result, updatedOrder);
    });
  });
}
