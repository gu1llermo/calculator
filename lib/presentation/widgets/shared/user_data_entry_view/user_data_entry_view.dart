import 'package:calculator_app/presentation/widgets/shared/data_widget/data_widget.dart';
import 'package:calculator_app/presentation/widgets/shared/pantalla_visualizacion/pantalla_visualizacion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDataEntryView extends ConsumerStatefulWidget {
  const UserDataEntryView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserDataEntryViewState();
}

class _UserDataEntryViewState extends ConsumerState<UserDataEntryView> {
  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(color: Colors.white);

    return const PantallaVisualizacion(
      child: DataWidget(
        alignment: Alignment.centerRight,
        data1: Text('Dato 1', style: textStyle),
        data2: Text('Dato 2', style: textStyle),
      ),
    );
  }
}
