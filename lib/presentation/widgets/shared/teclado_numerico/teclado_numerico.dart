import 'package:calculator_app/presentation/widgets/shared/teclado_numerico/botones_shapes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';

class TecladoNumerico extends ConsumerStatefulWidget {
  const TecladoNumerico({super.key, required this.height, required this.width});
  final double height;
  final double width;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomKeyboardState();
}

class _CustomKeyboardState extends ConsumerState<TecladoNumerico> {
  @override
  Widget build(BuildContext context) {
    // const double filas = 5;
    // const double columnas = 4;
    // final double anchoBoton = widget.width / columnas;
    // final double alturaBoton = widget.height / filas;
    // final double menor = min(alturaBoton, anchoBoton) - 2;

    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: const Column(
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
      ),
    );
  }
}

class Boton extends StatelessWidget {
  const Boton({super.key});
  // final double ancho;
  // final double alto;

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
        child: const Text(
          '1',
          style: TextStyle(fontSize: 25, color: Colors.white),
        ));
  }
}
