import 'package:calculator_app/presentation/widgets/calc/tasa_button.dart';
import 'package:calculator_app/presentation/widgets/shared/teclado_numerico/teclado_numerico.dart';
import 'package:calculator_app/presentation/widgets/shared/toggle_button/toggle_button_class.dart';
import 'package:calculator_app/presentation/widgets/shared/user_data_entry_view/user_data_entry_view.dart';
import 'package:calculator_app/presentation/widgets/shared/user_result_view/user_result_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PortraitView extends ConsumerWidget {
  const PortraitView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Padding(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TasaButton(),
              ToggleButton(),
              // toggleButton(ref)
              // aquí podría colocar otros botones
              // como el del historial
            ],
          ),
          Flexible(flex: 1, child: UserDataEntryView()),
          Flexible(flex: 1, child: UserResultView()),
          Flexible(flex: 3, child: TecladoNumerico()),
        ],
      ),
    );
  }
}


// return Padding(
//       padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const TasaButton(),
//               toggleButton(ref)
//               // aquí podría colocar otros botones
//               // como el del historial
//             ],
//           ),
//           const Flexible(flex: 1, child: UserDataEntryView()),
//           const Flexible(flex: 1, child: UserResultView()),
//           const Flexible(flex: 3, child: TecladoNumerico()),
//         ],
//       ),
//     );