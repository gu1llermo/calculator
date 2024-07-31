import 'package:calculator_app/config/helpers/tools.dart';
import 'package:calculator_app/presentation/providers/calc_provider.dart';
import 'package:calculator_app/presentation/widgets/shared/teclado_numerico/boton.dart';
import 'package:calculator_app/presentation/widgets/shared/teclado_numerico/botones_shapes.dart';
import 'package:calculator_app/services/local_storage/local_keys.dart';
import 'package:calculator_app/services/local_storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const indiceShapeIcon = Icon(
  Icons.shape_line,
  color: Colors.yellow,
);

const removeLastCharIcon = Icon(
  Icons.backspace_outlined,
  //color: Colors.white,
);

const _botonesTitle = <Widget>[
  // 1era Fila
  Boton(onPressed: clearButton, title: 'C'),
  Boton(onPressed: manejadorIndiceShape, icon: indiceShapeIcon),
  Boton(onPressed: removeLastChar, icon: removeLastCharIcon),
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
  Boton(onPressed: manejadorDeCeros, title: '00'),
  Boton(onPressed: manejadorDeCeros, title: '0'),
  Boton(onPressed: manejadorPuntoDecimal, title: '.'),
  Boton(onPressed: manejadorIgual, title: '='),
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
        final maxHeight = constraints.maxHeight;
        final double mainAxisExtent = maxHeight * 0.2;
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
      if (state.isEmpty) {
        if ((title == '/') || (title == '*') || (title == '+')) {
          return ''; //
        }
      }
      // dame el último caracter
      String lastChar = '';
      if (state.isNotEmpty) {
        lastChar = state.substring(state.length - 1, state.length);
      }
      String newState;
      if (contieneOperadorMatematico(lastChar) &&
          contieneOperadorMatematico(title)) {
        // sí el último carcater es un operador matemático
        // y quieres colocar otro operador matemático en su lugar
        // entonces lo reemplazamos

        newState =
            '${state.replaceRange(state.length - 1, state.length, title)}';
      } else {
        newState = '$state$title';
      }

      LocalStorage.prefs.setString(LocalKeys.userDataEntry, newState);
      return newState;
    },
  );

  if (!contieneOperadorMatematico(userDataEntry)) return; // no hagas nada
  // si llega aquí es porque tiene un operador matematico
  final result = Tools.calculate(userDataEntry);

  if (result.contains('Error')) return; // no actualices nada

  // ahora actualiza a userEntryResultPreview
  // no puede dar infinito aquí

  // entonces aquí actualiza a userEntryResultPreview
  ref.read(userDataPreviewResultProvider.notifier).update(
    (state) {
      LocalStorage.prefs.setString(LocalKeys.userDataPreviewResult, result);
      return result;
    },
  );
}

void manejadorDeCeros(String? title, WidgetRef ref) {
  // maneja los números 0 y 00
  if (title == null) return; // solo por seguridad que no haga nada
  // porque simepre tiene que tener un symbol

  final userDataEntry = ref.read(userDataEntryProvider.notifier).update(
    (state) {
      // aquí llega el 0 y 00

      String newState = '0';
      if (state != newState) {
        if (state.isNotEmpty) {
          newState = '$state$title';
        }
      }

      LocalStorage.prefs.setString(LocalKeys.userDataEntry, newState);
      return newState;
    },
  );

  if (!contieneOperadorMatematico(userDataEntry)) return; // no hagas nada
  // si llega aquí es porque tiene un operador matematico
  final result = Tools.calculate(userDataEntry);

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

void manejadorIgual(String? title, WidgetRef ref) {
  // debe borrar userDataEntry
  // y UserDataPreviewResult
  // y los dos de ab

  final userDataEntry = ref.read(userDataEntryProvider);
  if (!contieneOperadorMatematico(userDataEntry)) return;
  // no haces nada, lo dejas así

  final userDataPreviewResult = ref.read(userDataPreviewResultProvider);
  // en éste nivel me está diciendo que tiene al menos un operador matemático
  if (userDataPreviewResult.isEmpty) {
    // quiere decir que hay un error de syntaxis
    ref.read(userDataPreviewResultProvider.notifier).update(
      (state) {
        LocalStorage.prefs.setString(LocalKeys.userDataPreviewResult, 'Error');
        return 'Error';
      },
    );
    return;
  }
  if (userDataPreviewResult.contains('Error')) return; // no hagas nada
  if (userDataPreviewResult.contains('Infinity')) return; // no hagas nada
  // ya el usuario está avisado que hay un error

  // si llega a quí me parece que puede actualizar y hacer swap
  //

  final String subtitle = ref.read(userDataEntryProvider.notifier).update(
    (state) {
      // maneja los decimales
      String userDataPreviewResultAux =
          Tools.redondeaDecimalesFromTxt(userDataPreviewResult, 2);
      // me gustaría formatear en caso que haya decimales que sean 0
      userDataPreviewResultAux =
          Tools.eliminaDecimalCeroFromTxt(userDataPreviewResultAux);

      LocalStorage.prefs
          .setString(LocalKeys.userDataEntry, userDataPreviewResultAux);
      return userDataPreviewResultAux;
    },
  );

  ref.read(userDataPreviewResultProvider.notifier).update(
    (state) {
      LocalStorage.prefs.setString(LocalKeys.userDataPreviewResult, '');
      return '';
    },
  );
  // agrega al historial
  ref.read(historialProvider.notifier).add(userDataEntry, subtitle);

// no necesariamente es así
}

void removeLastChar(String? title, WidgetRef ref) {
  String userDataEntry = ref.read(userDataEntryProvider.notifier).update(
    (state) {
      String newState = '';
      if (state.isNotEmpty) {
        newState = state.substring(0, state.length - 1);
      }
      LocalStorage.prefs.setString(LocalKeys.userDataEntry, newState);
      return newState;
    },
  );

  final result = Tools.calculate(userDataEntry);

  ref.read(userDataPreviewResultProvider.notifier).update(
    (state) {
      String newState = '';
      if (!result.contains('Error') &&
          contieneOperadorMatematico(userDataEntry)) {
        newState = result;
      }

      LocalStorage.prefs.setString(LocalKeys.userDataPreviewResult, newState);
      return newState;
    },
  );
}

void manejadorPuntoDecimal(String? title, WidgetRef ref) {
  ref.read(userDataEntryProvider.notifier).update(
    (state) {
      String newState = '$state';

      if (sePuedeColocarDecimal(state)) {
        // entonces se lo colocamos
        newState += '.';
      }

      LocalStorage.prefs.setString(LocalKeys.userDataEntry, newState);
      return newState;
    },
  );
}

// tengo que implementar una función que dado un string me valide, si
bool sePuedeColocarDecimal(String data) {
  final vector =
      data.codeUnits.reversed.map((nro) => String.fromCharCode(nro)).toList();
  for (var caracter in vector) {
    if (contieneOperadorMatematico(caracter)) return true;
    if (caracter.contains('.')) return false;
  }
  return true;
}

// 2.5+65.

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
