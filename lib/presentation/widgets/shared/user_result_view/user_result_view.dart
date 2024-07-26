import 'package:calculator_app/presentation/widgets/shared/data_widget_view/data_widget.dart';
import 'package:calculator_app/presentation/widgets/shared/data_widget_view/data_widget_view.dart';
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
    String data1Txt = 'Parte Entera Dollar';
    String data2Txt = 'Restante en Moneda Local';
    String data1Symbol = '\$';
    String data2Symbol = 'Bs';

    return PantallaVisualizacion(
      child: DataWidgetView(
        crossAxisAlignment: CrossAxisAlignment.start,
        data1: DataWidget(txt: '$data1Txt $data1Symbol'),
        data2: DataWidget(txt: '$data2Txt $data2Symbol'),
      ),
    );
  }
}
