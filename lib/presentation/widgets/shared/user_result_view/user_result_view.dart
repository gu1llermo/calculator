import 'package:calculator_app/presentation/widgets/shared/data_widget/data_widget.dart';
import 'package:calculator_app/presentation/widgets/shared/pantalla_visualizacion/pantalla_visualizacion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserResultView extends ConsumerStatefulWidget {
  const UserResultView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserResultViewState();
}

class _UserResultViewState extends ConsumerState<UserResultView> {
  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(color: Colors.white);
    return const PantallaVisualizacion(
      child: DataWidget(
        alignment: Alignment.centerLeft,
        data1: Text('Dato 3', style: textStyle),
        data2: Text('Dato 4', style: textStyle),
      ),
    );
  }
}
