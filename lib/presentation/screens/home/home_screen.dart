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
      body: HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // portrait es vertical
    // lanscape es horizontal cuando se gira el celular
    final mediaQuery = MediaQuery.of(context);
    // final orientation = mediaQuery.orientation;
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;
    bool isPortrait = width < 600;
    // bool isPortrait = orientation == Orientation.portrait;

    return SingleChildScrollView(
      child: Stack(
        // alignment: Alignment.topCenter,
        children: [
          const _GradientBackground(),
          SizedBox(
            height: height,
            width: width,
            child: Column(
              children: [
                AppBar(
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  title: const Text('Calculator'),
                ),
                Expanded(
                    child: isPortrait
                        ? const PortraitView()
                        : const LandscapeView()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientBackground extends StatelessWidget {
  const _GradientBackground();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: const BoxDecoration(gradient: primaryGradient),
      ),
    );
  }
}
