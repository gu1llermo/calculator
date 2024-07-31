import 'package:calculator_app/presentation/widgets/shared/landscape/landscape_view.dart';
import 'package:calculator_app/presentation/widgets/shared/portrait/portrait_view.dart';
import 'package:flutter/material.dart';

const iconStar = Icon(
  Icons.star,
  color: Colors.yellow,
);

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
        // alignment: Alignment.bottomCenter,
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
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      iconStar,
                      iconStar,
                      iconStar,
                      iconStar,
                      iconStar,
                      // iconStar,
                      // iconStar,
                      // iconStar,
                    ],
                  ),
                ),
                // Container(
                //   height: 40,
                //   color: Colors.red,
                // ),
                Expanded(
                    child: isPortrait
                        ? const PortraitView()
                        : const LandscapeView()),
              ],
            ),
          ),
          //Estrellas(height: height, width: width)
        ],
      ),
    );
  }
}

class Estrellas extends StatelessWidget {
  const Estrellas({super.key, required this.height, required this.width});
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: height / 3,
        ),
        getStars(60),
        getStars(150),
        getStars(240),
        getStars(330),
      ],
    );
  }

  SizedBox getStars(double width) {
    return SizedBox(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [iconStar, iconStar],
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
        decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1)),
        //decoration: const BoxDecoration(gradient: primaryGradient),
      ),
    );
  }
}
