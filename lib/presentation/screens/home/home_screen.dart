import 'package:calculator_app/config/helpers/backgrounds.dart';
import 'package:calculator_app/presentation/widgets/shared/landscape/landscape_view.dart';
import 'package:calculator_app/presentation/widgets/shared/portrait/portrait_view.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String path = '/';
  static const String name = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(
      //   title: const Text('Calculator'),
      // ),
      body: HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    // portrait es vertical
    // lanscape es horizontal cuando se gira el celular
    return Stack(
      // alignment: Alignment.topCenter,
      children: [
        Container(
          decoration: const BoxDecoration(gradient: primaryGradient),
        ),
        const _Header(),
        (orientation == Orientation.portrait)
            ? const PortraitView()
            : const LandscapeView(),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final paddingTop = MediaQuery.of(context).padding.top;
    final fontSize = Theme.of(context).textTheme.titleLarge?.fontSize;

    return Padding(
      padding: EdgeInsets.only(top: paddingTop + 5, left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(height: fontSize, width: 10, color: Colors.black),
          const Text(
            'Calculadora',
            style: TextStyle(fontSize: 24),
          ),
          Container(height: fontSize, width: 10, color: Colors.black),
        ],
      ),
    );
  }
}
