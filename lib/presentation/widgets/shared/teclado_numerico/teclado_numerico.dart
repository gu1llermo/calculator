import 'package:calculator_app/presentation/widgets/shared/teclado_numerico/botones_shapes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';

class TecladoNumerico extends ConsumerStatefulWidget {
  const TecladoNumerico({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TecladoNumericoState();
}

class _TecladoNumericoState extends ConsumerState<TecladoNumerico> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Boton(), Boton(), Boton(), Boton()]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Boton(), Boton(), Boton(), Boton()]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Boton(), Boton(), Boton(), Boton()]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Boton(), Boton(), Boton(), Boton()]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Boton(), Boton(), Boton(), Boton()]),
      ],
    );
  }
}

class Boton extends StatelessWidget {
  const Boton({super.key, this.child = const _DefaultBotonWidget()});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Icons.transform;
    return ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            shape: botonesShape[1], // StadiumBorder() / CircleBorder()
            backgroundColor: Colors.white10,
            animationDuration: const Duration(seconds: 1),
            elevation: 4,
            fixedSize: const Size.fromRadius(30)),
        child: child);
  }
}

class _DefaultBotonWidget extends StatelessWidget {
  const _DefaultBotonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      '1',
      style: TextStyle(fontSize: 25, color: Colors.white),
    );
  }
}
