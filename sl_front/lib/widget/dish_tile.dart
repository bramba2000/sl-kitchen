import 'package:flutter/material.dart';
import 'package:sl_common/model/dish.dart';

class DishTile extends StatelessWidget {
  final Dish _dish;
  final bool hasPicture;
  const DishTile(this._dish, {super.key}) : hasPicture = true;

  static const _containerPadding =
      EdgeInsets.symmetric(horizontal: 10, vertical: 5);
  static const _textPadding = EdgeInsets.symmetric(horizontal: 10, vertical: 2);
  static const _InfoTextStyle = TextStyle(
      fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF565656));
  static const _maxCharacters = 80;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color(0x22656565))),
        padding: _containerPadding,
        margin: const EdgeInsets.all(0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: _textPadding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _dish.name,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                        _dish.description.length > _maxCharacters
                            ? '${_dish.description.substring(0, _maxCharacters)}...'
                            : _dish.description,
                        style: _InfoTextStyle),
                    Text(
                      '${_dish.price}€',
                      style: _InfoTextStyle,
                    )
                  ],
                ),
              ),
            ),
            hasPicture
                ? const SizedBox(
                    width: 68,
                    height: 68,
                    child: Placeholder(),
                  )
                : const SizedBox.shrink(),
          ],
        ));
  }
}
