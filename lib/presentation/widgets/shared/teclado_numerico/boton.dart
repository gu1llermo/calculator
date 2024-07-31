import 'package:calculator_app/presentation/providers/calc_provider.dart';
import 'package:calculator_app/presentation/widgets/shared/teclado_numerico/botones_shapes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef ButtonHandler = void Function(String? title, WidgetRef ref);

class Boton extends ConsumerWidget {
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

  final ButtonHandler onPressed;
  final ButtonHandler? onLongPress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indiceShape = ref.watch(indiceShapeProvider);

    final bool isIcon = icon != null;
    final bool isTitle = title != null;
    final bool isDefaultWidget = !isIcon &&
        !isTitle; // si no hay ni ícono ni title entonces le colocamos un defaultWidget

    const textStyle = TextStyle(
      // color: titleColor ?? Colors.white,
      fontSize: 22,
    );
    final Widget defaultWidget = Text('X', style: textStyle);
    final Widget child = isDefaultWidget
        ? defaultWidget
        : isIcon
            ? icon!
            : Text(title!, style: textStyle);

    return Container(
      margin: const EdgeInsets.all(4),
      child: ElevatedButton(
          onPressed: () => onPressed(isDefaultWidget ? 'X' : title, ref),
          onLongPress: () {
            if (onLongPress != null) onLongPress!(title, ref);
          },
          style: ElevatedButton.styleFrom(
            shape:
                botonesShape[indiceShape], // StadiumBorder() / CircleBorder()
            backgroundColor: Colors.white10,
            animationDuration: const Duration(seconds: 1),
            elevation: 4,
          ),
          child: child),
    );
  }
}
