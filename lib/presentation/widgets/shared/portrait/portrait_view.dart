import 'package:calculator_app/presentation/widgets/calc/tasa_button.dart';
import 'package:calculator_app/presentation/widgets/shared/teclado_numerico/teclado_numerico.dart';
import 'package:flutter/material.dart';

class PortraitView extends StatelessWidget {
  const PortraitView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TasaButton(),
            ],
          ),
          Flexible(flex: 1, child: UserView()),
          Flexible(flex: 1, child: UserView()),
          Flexible(flex: 3, child: TecladoNumerico()),
        ],
      ),
    );
  }
}

class UserView extends StatelessWidget {
  final Widget child;
  const UserView({super.key, this.child = const Placeholder()});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black12, borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
