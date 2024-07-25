import 'package:calculator_app/presentation/widgets/calc/tasa_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LandscapeView extends ConsumerWidget {
  const LandscapeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(child: TasaButton());
  }
}
