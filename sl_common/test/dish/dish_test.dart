import 'package:flutter_test/flutter_test.dart';
import 'package:sl_common/model/dish.dart';

void main() {
  test('Serialization of dish w/o addons', () {
    const dish = Dish(
      name: 'name',
      description: 'description',
      price: 1.0,
    );
    final json = dish.toJson();
    expect(json['name'], 'name');
    expect(json['description'], 'description');
    expect(json['price'], 1.0);
    expect(json['addons'], null);
  });

  test('Serialization of dish w/ addons', () {
    const dish = Dish(
      name: 'name',
      description: 'description',
      price: 1.0,
      addons: ['addon1', 'addon2'],
    );
    final json = dish.toJson();
    expect(json['name'], 'name');
    expect(json['description'], 'description');
    expect(json['price'], 1.0);
    expect(json['addons'].length, 2);
    expect(json['addons'], ['addon1', 'addon2']);
  });

  test('Creation of dish w/ addons', () {
    final json = {
      'name': 'name',
      'description': 'description',
      'price': 1.0,
      'addons': ['addon1', 'addon2'],
    };
    final dish = Dish.fromJson(json);
    expect(dish.name, 'name');
    expect(dish.description, 'description');
    expect(dish.price, 1.0);
    expect(dish.addons, ['addon1', 'addon2']);
  });
}
