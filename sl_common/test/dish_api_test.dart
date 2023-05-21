import 'package:flutter_test/flutter_test.dart';
import 'package:sl_common/api/dish_api.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:sl_common/model/dish.dart';

void main() {
  group("Test API of dishes - ", () {
    late FakeFirebaseFirestore fakeInstance;
    late DishApi api;

    setUp(() async {
      fakeInstance = FakeFirebaseFirestore();
      api = DishApi(fakeInstance);
    });

    test("Test creation of a dish", () async {
      const dish = Dish(
        name: 'name',
        description: 'description',
        price: 1.0,
        addons: ['addon1', 'addon2'],
      );
      await api.addDish(dish);
      expect((await fakeInstance.collection('dishes').get()).size, isNonZero);
      Dish result = Dish.fromJson(
          (await fakeInstance.collection('dishes').get()).docs.first.data());
      expect(result, isNotNull);
      expect(result.name, dish.name);
      expect(result.description, dish.description);
      expect(result.price, dish.price);
      expect(result.addons, dish.addons);
      expect(result.hashCode, dish.hashCode);
    });

    test("Test retrieving a dish", () async {
      const dish = Dish(
        name: 'name',
        description: 'description',
        price: 1.0,
        addons: ['addon1', 'addon2'],
      );
      fakeInstance.collection('dishes').add(dish.toJson());
      expect(api.getDish('name', useCache: true), completion(equals(dish)));
      expect(api.getDish('name'), completion(equals(dish)));
      expect(api.getDish('name', useCache: true), completion(equals(dish)));
    });

    test("Test retrieving multiple dishes", () {
      const dishes = [
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
        Dish(
          name: 'name3',
          description: 'description3',
          price: 3.0,
          addons: ['addon5', 'addon6'],
        ),
      ];
      dishes.forEach(
          (dish) => fakeInstance.collection('dishes').add(dish.toJson()));
      expect(api.getDishes(useCache: true), completion(containsAll(dishes)));
    });

    test("Test retrieve a non existing dish", () async {
      await expectLater(api.getDish('name'), throwsStateError);
    });

    test("Test delete a dish", () async {
      const dish = Dish(
        name: 'name',
        description: 'description',
        price: 1.0,
        addons: ['addon1', 'addon2'],
      );
      await fakeInstance.collection('dishes').add(dish.toJson());
      await api.getDishes();
      await api.deleteDish(dish);
      expect(api.getDishes(useCache: true), completion(isEmpty));
      expect((await fakeInstance.collection('dishes').get()).docs, isEmpty);
    });

    tearDown(() {
      print(fakeInstance.dump());
    });

    test("Test delete a dish not present", () async {
      const dish = Dish(
        name: 'name',
        description: 'description',
        price: 1.0,
        addons: ['addon1', 'addon2'],
      );
      await expectLater(api.deleteDish(dish), throwsStateError);
    });
  });
}
