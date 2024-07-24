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
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: const HomeView(),
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
      children: [
        Container(
          decoration: const BoxDecoration(gradient: primaryGradient),
        ),
        (orientation == Orientation.portrait)
            ? const PortraitView()
            : const LandscapeView(),
      ],
    );
  }
}
