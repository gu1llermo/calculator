import 'package:calculator_app/presentation/providers/calc_provider.dart';
import 'package:calculator_app/services/local_storage/local_keys.dart';
import 'package:calculator_app/services/local_storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditButton extends ConsumerWidget {
  const EditButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
        onPressed: () {
          _dialogBuilder(context, ref);
        },
        icon: const Icon(
          Icons.edit_document,
          size: 26,
        ));
  }

  Future<void> _dialogBuilder(BuildContext context, WidgetRef ref) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Seleccione Moneda'),
          content: SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: SelectSymbol(
                    helperText: 'BASE',
                    symbolProvider: monedaBaseProvider,
                    localKey: LocalKeys.monedaBase,
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: SelectSymbol(
                    helperText: 'LOCAL',
                    symbolProvider: symbolMonedaLocalProvider,
                    localKey: LocalKeys.symbolMonedaLocal,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SelectSymbol extends ConsumerWidget {
  const SelectSymbol(
      {super.key,
      required this.helperText,
      required this.symbolProvider,
      required this.localKey});
  final String helperText;
  final StateProvider<String> symbolProvider;
  final String localKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> symbols = ['\$', 'Bs', 'COP', 'CLP', 'EUR'];
    final initialSymbol = ref.read(symbolProvider);
    final textEditingController = TextEditingController(text: initialSymbol);
    final userDataEntrySymbol = ref.read(userDataEntrySymbolProvider);
    return DropdownMenu<String>(
      expandedInsets: EdgeInsets.zero,
      dropdownMenuEntries: symbols
          .map((symbol) => DropdownMenuEntry<String>(
                value: symbol,
                label: symbol,
              ))
          .toList(),
      helperText: helperText,
      controller: textEditingController,
      onSelected: (value) {
        if (initialSymbol == userDataEntrySymbol) {
          ref.read(userDataEntrySymbolProvider.notifier).update((state) {
            LocalStorage.prefs.setString(LocalKeys.userDataEntrySymbol, value!);
            return value;
          });
        }
        ref.read(symbolProvider.notifier).update(
          (state) {
            LocalStorage.prefs.setString(localKey, value!);
            return value;
          },
        );
      },
    );
  }
}
