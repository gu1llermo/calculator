import 'package:calculator_app/presentation/widgets/calc/tasa_button.dart';
import 'package:calculator_app/presentation/widgets/shared/teclado_numerico/teclado_numerico.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PortraitView extends StatelessWidget {
  const PortraitView({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final paddingTop = mediaQuery.padding.top;
    // final fontSize = 20;
    final fontSize = Theme.of(context).textTheme.titleLarge?.fontSize ?? 20;

    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;

    final desplazamientoSuperior = 2 * paddingTop + fontSize;
    const double desplazamientoInferior = 10;

    final alturaDisponible = height -
        desplazamientoSuperior -
        desplazamientoInferior -
        2.5 * fontSize;
    final altura1 = 0.19 * alturaDisponible;
    final altura11 = 0.01 * alturaDisponible;
    final altura2 = 0.59 * alturaDisponible;

    return Padding(
      padding: EdgeInsets.only(
          left: 10,
          right: 10,
          top: desplazamientoSuperior,
          bottom: desplazamientoInferior),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TasaButton(),
            SizedBox(
              height: altura11,
            ),

            UserInputView(
              altura: altura1,
              color: Colors.black12,
            ),
            SizedBox(
              height: altura11,
            ),
            UserInputView(
              altura: altura1,
              color: Colors.black12,
            ),
            SizedBox(
              height: altura11,
            ),

            TecladoNumerico(height: altura2, width: width - 20),
            // ConvertionView(),
            // CustomKeyboard(),
          ],
        ),
      ),
    );
  }
}

class UserInputView extends StatelessWidget {
  final Color color;
  final double altura;
  const UserInputView({super.key, required this.color, required this.altura});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: altura,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
    );
  }
}
