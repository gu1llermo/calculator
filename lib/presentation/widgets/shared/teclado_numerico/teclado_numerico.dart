import 'package:calculator_app/config/helpers/tools.dart';
import 'package:calculator_app/presentation/providers/calc_provider.dart';
import 'package:calculator_app/presentation/widgets/shared/teclado_numerico/boton.dart';
import 'package:calculator_app/presentation/widgets/shared/teclado_numerico/botones_shapes.dart';
import 'package:calculator_app/services/local_storage/local_keys.dart';
import 'package:calculator_app/services/local_storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_expressions/math_expressions.dart';

const _botonesTitle = <Widget>[
  // 1era Fila
  Boton(onPressed: clearButton, title: 'C'),
  Boton(
    onPressed: manejadorIndiceShape,
    icon: Icon(
      Icons.shape_line,
      color: Colors.yellow,
    ),
  ),
  Boton(
    onPressed: removeLastChar,
    icon: Icon(
      Icons.backspace_outlined,
      color: Colors.white,
    ),
  ),
  Boton(onPressed: manejadorDeNumeros, title: '/'),
  //
  // 2da Fila
  Boton(onPressed: manejadorDeNumeros, title: '7'),
  Boton(onPressed: manejadorDeNumeros, title: '8'),
  Boton(onPressed: manejadorDeNumeros, title: '9'),
  Boton(onPressed: manejadorDeNumeros, title: '*'),
  //
  // 3era Fila
  Boton(onPressed: manejadorDeNumeros, title: '4'),
  Boton(onPressed: manejadorDeNumeros, title: '5'),
  Boton(onPressed: manejadorDeNumeros, title: '6'),
  Boton(onPressed: manejadorDeNumeros, title: '-'),
  //
  // 4ta Fila
  Boton(onPressed: manejadorDeNumeros, title: '1'),
  Boton(onPressed: manejadorDeNumeros, title: '2'),
  Boton(onPressed: manejadorDeNumeros, title: '3'),
  Boton(onPressed: manejadorDeNumeros, title: '+'),
  //
  // 5ta Fila

  Boton(onPressed: manejadorDeNumeros, title: '00'),
  Boton(onPressed: manejadorDeNumeros, title: '0'),
  Boton(onPressed: manejadorPuntoDecimal, title: '.'),
  Boton(
    onPressed: manejadorDeNumeros,
    title: '=',
    titleColor: Colors.white,
  ),
];

class TecladoNumerico extends ConsumerStatefulWidget {
  const TecladoNumerico({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TecladoNumericoState();
}

class _TecladoNumericoState extends ConsumerState<TecladoNumerico> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // print('Constraints -> $constraints');
        final maxHeight = constraints.maxHeight;
        final double mainAxisExtent = maxHeight * 0.2;
        // print('mainAxisExtent -> $mainAxisExtent');

        return GridView.builder(
          padding: const EdgeInsets.only(top: 0),
          itemCount: _botonesTitle.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, mainAxisExtent: mainAxisExtent),
          itemBuilder: (context, index) {
            return _botonesTitle[index];
          },
        );
      },
    );
  }
}

void manejadorDeNumeros(String? title, WidgetRef ref) {
  // maneja los números del 1 al 9
  if (title == null) return; // solo por seguridad que no haga nada
  // porque simepre tiene que tener un symbol

  final userDataEntry = ref.read(userDataEntryProvider.notifier).update(
    (state) {
      final newState = '$state$title';
      LocalStorage.prefs.setString(LocalKeys.userDataEntry, newState);
      return newState;
    },
  );

  if (!contieneOperadorMatematico(userDataEntry)) return; // no hagas nada
  // si llega aquí es porque tiene un operador matematico
  final result = calculate(userDataEntry);

  if (result.contains('Error')) return; // no actualices nada

  // ahora actualiza a userEntryResultPreview
  // no puede dar infinito aquí

  // entonces aquí actualiza a userEntryResultPreview
  ref.read(userDataPreviewResultProvider.notifier).update(
    (state) {
      LocalStorage.prefs.setString(LocalKeys.userDataPreviewResult, result);
      return result;
      // return Tools.eliminaDecimalCeroFromTxt(result);
    },
  );
}

bool contieneOperadorMatematico(String userDataEntry) {
  if (userDataEntry.contains('/')) return true;
  if (userDataEntry.contains('+')) return true;
  if (userDataEntry.contains('-')) return true;
  if (userDataEntry.contains('*')) return true;

  return false;
}

String calculate(String userInput) {
  // Infinity : cuando se divide por 0
  // RangeError cuando no está completamente bien armada la expresión
  // por ejemplo escriben 5+ y quieren un resultado
  // ó escriben 5+*-+*/ cosas así

  // FormatException no debería aparecer, pero aparece cuando permites
  // armar mal una expresión

  try {
    final expression = Parser().parse(userInput);
    final evaluation = expression.evaluate(EvaluationType.REAL, ContextModel());
    print('evaluation= $evaluation');
    return evaluation.toString();
  } on RangeError {
    return 'RangeError';
  } catch (e) {
    // print('e -> $e');
    // e -> RangeError (index): Invalid value: Valid value range is empty: -1
    // es por faltan argumentos, por ejemplo 1+ y le damos enter
    return e
        .toString(); // no debería llegar aquí nunca, porque tengo que controlar bien las entradas
  }
}

void clearButton(String? title, WidgetRef ref) {
  // debe borrar userDataEntry
  // y UserDataPreviewResult
  // y los dos de ab
  ref.read(userDataEntryProvider.notifier).update(
    (state) {
      LocalStorage.prefs.setString(LocalKeys.userDataEntry, '');
      return '';
    },
  );
  ref.read(userDataPreviewResultProvider.notifier).update(
    (state) {
      LocalStorage.prefs.setString(LocalKeys.userDataPreviewResult, '');
      return '';
    },
  );
}

void removeLastChar(String? title, WidgetRef ref) {
  ref.read(userDataEntryProvider.notifier).update(
    (state) {
      String newState = '';
      if (!state.isEmpty) {
        newState = state.substring(0, state.length - 1);
      }
      LocalStorage.prefs.setString(LocalKeys.userDataEntry, newState);
      return newState;
    },
  );

  // ref.read(userDataPreviewResultProvider.notifier).update(
  //   (state) {
  //     LocalStorage.prefs.setString(LocalKeys.userDataPreviewResult, '');
  //     return '';
  //   },
  // );
}

void manejadorPuntoDecimal(String? title, WidgetRef ref) {
  ref.read(userDataEntryProvider.notifier).update(
    (state) {
      String newState = '$state';
      if (!state.contains('.')) {
        // sino contiene un punto decimal
        // entonces se lo colocamos
        newState += '.';
      }

      LocalStorage.prefs.setString(LocalKeys.userDataEntry, newState);
      return newState;
    },
  );

  // ref.read(userDataPreviewResultProvider.notifier).update(
  //   (state) {
  //     LocalStorage.prefs.setString(LocalKeys.userDataPreviewResult, '');
  //     return '';
  //   },
  // );
}

void manejadorIndiceShape(String? title, WidgetRef ref) {
  // lo que hace es cambiar el índice shape
  ref.read(indiceShapeProvider.notifier).update((state) {
    final lenght = botonesShape.length;
    int indiceResult = 0;
    if (state < lenght - 1) {
      indiceResult = state + 1;
    }
    // ahora guarda en preferencias éste valor
    LocalStorage.prefs.setInt(LocalKeys.indiceShape, indiceResult);

    return indiceResult;
  });
}
