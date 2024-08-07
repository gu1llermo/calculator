import 'package:calculator_app/presentation/providers/calc_provider.dart';
import 'package:calculator_app/services/local_storage/local_keys.dart';
import 'package:calculator_app/services/local_storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// depende de la moneda del usuario seleccionada debería mostrar una opción u otra
class ToggleButton extends ConsumerWidget {
  const ToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // aquí tengo que hacer un toggle entre moneda local
    // dólares
    final String symbol = ref.watch(userDataEntrySymbolProvider);

    return TextButton(
      onPressed: () {
        final String symbolMonedaLocal = ref.read(symbolMonedaLocalProvider);
        final String userDataEntrySymbol =
            ref.read(userDataEntrySymbolProvider);
        final monedaBase = ref.watch(monedaBaseProvider);
        String symbolToggle = '$monedaBase';

        if (userDataEntrySymbol == monedaBase) {
          // la moneda base es el dolar en estos casos
          // entonces le asignamos la moneda local
          symbolToggle = symbolMonedaLocal;
        }

        ref.read(userDataEntrySymbolProvider.notifier).update((state) {
          LocalStorage.prefs
              .setString(LocalKeys.userDataEntrySymbol, symbolToggle);
          return symbolToggle;
        });
      },
      child: Text(
        symbol,
        style: const TextStyle(
          //color: Colors.white,
          fontSize: 24,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
