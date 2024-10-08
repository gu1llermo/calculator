import 'package:calculator_app/presentation/widgets/calc/tasa_button.dart';
import 'package:calculator_app/presentation/widgets/shared/edit_button/edit_button.dart';
import 'package:calculator_app/presentation/widgets/shared/history_button/history_button.dart';
import 'package:calculator_app/presentation/widgets/shared/teclado_numerico/teclado_numerico.dart';
import 'package:calculator_app/presentation/widgets/shared/toggle_button/toggle_button_class.dart';
import 'package:calculator_app/presentation/widgets/shared/user_data_entry_view/user_data_entry_view.dart';
import 'package:calculator_app/presentation/widgets/shared/user_result_view/user_result_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LandscapeView extends ConsumerWidget {
  const LandscapeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Padding(
      padding: EdgeInsets.only(left: 10, right: 0, bottom: 10),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(flex: 1, child: TasaButton()),
                      Flexible(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            EditButton(),
                            HistoryButton(heightFactor: 0.7),
                            ToggleButton(),
                          ],
                        ),
                      ),
                      // toggleButton(ref)
                      // aquí podría colocar otros botones
                      // como el del historial
                    ],
                  ),
                  UserDataEntryView(),
                  UserResultView(),
                ],
              ),
            ),
          ),
          Flexible(flex: 1, child: TecladoNumerico()),
        ],
      ),
    );
  }
}
