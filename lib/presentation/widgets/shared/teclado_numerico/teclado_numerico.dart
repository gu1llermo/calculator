import 'package:calculator_app/presentation/providers/calc_provider.dart';
import 'package:calculator_app/presentation/widgets/shared/teclado_numerico/boton.dart';
import 'package:calculator_app/presentation/widgets/shared/teclado_numerico/botones_shapes.dart';
import 'package:calculator_app/services/local_storage/local_keys.dart';
import 'package:calculator_app/services/local_storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _botonesTitle = <Widget>[
  // 1era Fila
  Boton(onPressed: manejadorDeNumeros, title: 'C'),
  Boton(onPressed: manejadorDeNumeros, title: '%'),
  Boton(
    onPressed: manejadorDeNumeros,
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
  Boton(
    onPressed: manejadorIndiceShape,
    icon: Icon(
      Icons.shape_line,
      color: Colors.yellow,
    ),
  ),
  Boton(onPressed: manejadorDeNumeros, title: '0'),
  Boton(onPressed: manejadorDeNumeros, title: '.'),
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
  print(title ?? 'No hay title');
}

void clearButton(String? title, WidgetRef ref) {
  // debe borrar userDataEntry
  // y UserDataPreviewResult
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
