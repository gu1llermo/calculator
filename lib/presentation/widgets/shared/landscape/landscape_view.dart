import 'package:calculator_app/presentation/widgets/calc/tasa_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LandscapeView extends ConsumerWidget {
  const LandscapeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paddingTop = MediaQuery.of(context).padding.top;
    final fontSize = Theme.of(context).textTheme.titleLarge?.fontSize ?? 25;

    return Positioned(
      top: 2 * paddingTop + fontSize,
      left: 10,
      child: const TasaButton(),
    );
  }
}
