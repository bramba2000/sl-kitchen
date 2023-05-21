import 'package:json_annotation/json_annotation.dart';

enum OrderStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('payed')
  payed,
  @JsonValue('rejected')
  rejected,
  @JsonValue('delivered')
  delivered,
}
