// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Order _$$_OrderFromJson(Map<String, dynamic> json) => _$_Order(
      dishes: (json['dishes'] as List<dynamic>)
          .map((e) => Dish.fromJson(e as Map<String, dynamic>))
          .toList(),
      identifier: json['identifier'] as String,
      status: $enumDecode(_$OrderStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$$_OrderToJson(_$_Order instance) => <String, dynamic>{
      'dishes': instance.dishes,
      'identifier': instance.identifier,
      'status': _$OrderStatusEnumMap[instance.status]!,
    };

const _$OrderStatusEnumMap = {
  OrderStatus.pending: 'pending',
  OrderStatus.payed: 'payed',
  OrderStatus.rejected: 'rejected',
  OrderStatus.delivered: 'delivered',
};
