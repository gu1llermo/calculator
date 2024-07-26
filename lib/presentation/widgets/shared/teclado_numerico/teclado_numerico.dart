import 'package:calculator_app/presentation/widgets/shared/teclado_numerico/botones_shapes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _botonesTitle = <Widget>[
  // 1era Fila
  Boton(onPressed: manejadorDeNumeros, title: 'C'),
  Boton(onPressed: manejadorDeNumeros, title: '%'),
  Boton(
    onPressed: manejadorDeNumeros,
    icon: Icon(Icons.backspace_outlined),
  ),
  Boton(onPressed: manejadorDeNumeros, title: '/'),
  // 2da Fila
  Boton(onPressed: manejadorDeNumeros, title: '7'),
  Boton(onPressed: manejadorDeNumeros, title: '8'),
  Boton(onPressed: manejadorDeNumeros, title: '9'),
  Boton(onPressed: manejadorDeNumeros, title: '*'),
  // 3era Fila
  Boton(onPressed: manejadorDeNumeros, title: '4'),
  Boton(onPressed: manejadorDeNumeros, title: '5'),
  Boton(onPressed: manejadorDeNumeros, title: '6'),
  Boton(onPressed: manejadorDeNumeros, title: '-'),
  // 4ta Fila
  Boton(onPressed: manejadorDeNumeros, title: '1'),
  Boton(onPressed: manejadorDeNumeros, title: '2'),
  Boton(onPressed: manejadorDeNumeros, title: '3'),
  Boton(onPressed: manejadorDeNumeros, title: '+'),
  // 5ta Fila
  Boton(
    onPressed: manejadorDeNumeros,
    icon: Icon(Icons.transform),
  ),
  Boton(onPressed: manejadorDeNumeros, title: '0'),
  Boton(onPressed: manejadorDeNumeros, title: '.'),
  Boton(onPressed: manejadorDeNumeros, title: '='),
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

typedef CalcHandler = void Function(String? title);

void manejadorDeNumeros(String? title) {
  print(title ?? 'No hay title');
}

class Boton extends StatelessWidget {
  const Boton({
    super.key,
    this.icon,
    this.title,
    required this.onPressed,
    this.onLongPress,
    this.titleColor,
  }) : assert(icon == null || title == null);
  // quiero que solamente pueda ingresar un ícono ó un title, pero no los dos a la vez
  final Icon? icon;

  final String? title;
  final Color? titleColor;

  final CalcHandler onPressed;
  final CalcHandler? onLongPress;

  @override
  Widget build(BuildContext context) {
    Icons.transform;

    final bool isIcon = icon != null;
    final bool isTitle = title != null;
    final bool isDefaultWidget = !isIcon &&
        !isTitle; // si no hay ni ícono ni title entonces le colocamos un defaultWidget

    final textStyle =
        TextStyle(color: titleColor ?? Colors.white, fontSize: 26);
    final Widget defaultWidget = Text('X', style: textStyle);
    final Widget child = isDefaultWidget
        ? defaultWidget
        : isIcon
            ? icon!
            : Text(title!, style: textStyle);

    return Container(
      margin: const EdgeInsets.all(4),
      child: ElevatedButton(
          onPressed: () => onPressed(isDefaultWidget ? 'X' : title),
          onLongPress: () {
            if (onLongPress != null) onLongPress!(title);
          },
          style: ElevatedButton.styleFrom(
            shape: botonesShape[1], // StadiumBorder() / CircleBorder()
            backgroundColor: Colors.white10,
            animationDuration: const Duration(seconds: 1),
            elevation: 4,
          ),
          child: child),
    );
  }
}
