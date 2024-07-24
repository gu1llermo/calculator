import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PortraitView extends ConsumerWidget {
  const PortraitView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(child: TasaButton());
  }
}

class TasaButton extends StatelessWidget {
  const TasaButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();
    final tasaEditController = TextEditingController();
    final fontSizeLabel = Theme.of(context).textTheme.titleMedium?.fontSize;
    final labelTextStyle =
        TextStyle(color: Colors.white, fontSize: fontSizeLabel);

    return TextField(
      focusNode: focusNode,
      controller: tasaEditController,
      onTapOutside: (event) {
        focusNode.unfocus();
      },
      decoration: InputDecoration(
          labelText: 'Tasa',
          labelStyle: labelTextStyle,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffix: const Text('Bs'),
          suffixStyle: labelTextStyle,
          filled: true,
          fillColor: Colors.black26),
    );
  }
}
