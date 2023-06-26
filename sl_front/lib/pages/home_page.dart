import 'package:flutter/material.dart';
import '../widgets/dish_tile.dart';
import 'package:sl_common/model/dish.dart';
import '../themes/light_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  static const _globalPadding = EdgeInsets.all(10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.0,
        backgroundColor: Colors.white,
        title: const _Header(),
        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        padding: _globalPadding,
        child: const DishTile(
          Dish(
              name: 'Pasta al ragù',
              description:
                  'Pasta al ragù con carne di manzo e verdure preparato a mano stamattina fresco dalla nonna di zio tobia',
              price: 10.0),
        ),
      ),
      bottomNavigationBar: _Footer(),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 45,
          height: 51.43,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/icons/logo.jpg'),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        const Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'SAN LUIGI ',
                style: TextStyle(
                  color: SLKTheme.primaryColor,
                  fontSize: 24,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(
                text: 'KITCHEN',
                style: TextStyle(
                  color: SLKTheme.accentColor,
                  fontSize: 24,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  static const _height = 50.0;
  static const _buttonPadding =
      EdgeInsets.symmetric(horizontal: 20, vertical: 10);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Container(
      height: _height,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: _theme.canvasColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 3,
            blurRadius: 5,
          ),
        ],
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: null,
              child: Padding(
                padding: _buttonPadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    SizedBox.square(
                      dimension: 10,
                    ),
                    Text(
                      'CARRELLO VUOTO',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
