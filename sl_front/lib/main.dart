import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

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
      body: const Center(
        child: Text('Hello Worlds!'),
      ),
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
              fit: BoxFit.fill,
            ),
          ),
        ),
        const Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'SAN LUIGI ',
                style: TextStyle(
                  color: Color(0xFFC8AA87),
                  fontSize: 24,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(
                text: 'KITCHEN',
                style: TextStyle(
                  color: Color(0xFF616068),
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
    ;
  }
}
