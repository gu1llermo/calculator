import 'package:calculator_app/presentation/providers/calc_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

IconButton toggleButton(WidgetRef ref) {
  return IconButton(
      onPressed: () {
        // aquí tengo que hacer un toggle entre moneda local
        // dólares
        final String symbolMonedaLocal = ref.read(symbolMonedaLocalProvider);

        final String userDataEntrySymbol =
            ref.read(userDataEntrySymbolProvider);
        final monedaBase = ref.read(monedaBaseProvider);

        String symbolToggle = '$monedaBase';

        if (userDataEntrySymbol == monedaBase) {
          // la moneda base es el dolar en estos casos
          // entonces le asignamos la moneda local
          symbolToggle = symbolMonedaLocal;
        }

        ref.read(userDataEntrySymbolProvider.notifier).update((state) {
          return symbolToggle;
        });
      },
      icon: const Icon(
        Icons.change_circle_outlined,
        size: 30,
        //color: Colors.white,
        fill: 0.5,
      ));
}
