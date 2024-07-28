import 'package:calculator_app/presentation/widgets/calc/tasa_button.dart';
import 'package:calculator_app/presentation/widgets/shared/teclado_numerico/teclado_numerico.dart';
import 'package:calculator_app/presentation/widgets/shared/toggle_button/toggle_button.dart';
import 'package:calculator_app/presentation/widgets/shared/user_data_entry_view/user_data_entry_view.dart';
import 'package:calculator_app/presentation/widgets/shared/user_result_view/user_result_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LandscapeView extends ConsumerWidget {
  const LandscapeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TasaButton(),
                    toggleButton(ref)
                    // aquí podría colocar otros botones
                    // como el del historial
                  ],
                ),
                const UserDataEntryView(),
                const UserResultView(),
              ],
            ),
          ),
          const Flexible(flex: 1, child: TecladoNumerico()),
        ],
      ),
    );
  }
}
