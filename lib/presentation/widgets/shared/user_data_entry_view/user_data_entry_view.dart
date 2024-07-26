import 'package:calculator_app/presentation/widgets/shared/data_widget_view/data_widget.dart';
import 'package:calculator_app/presentation/widgets/shared/data_widget_view/data_widget_view.dart';
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
    String data1Txt = 'Data 1';
    String data2Txt = 'Data 2';
    String symbol = '\$';

    return PantallaVisualizacion(
      child: DataWidgetView(
        crossAxisAlignment: CrossAxisAlignment.end,
        data1: DataWidget(txt: '$data1Txt $symbol'),
        data2: DataWidget(txt: '$data2Txt $symbol'),
      ),
    );
  }
}
