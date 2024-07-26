import 'package:calculator_app/presentation/providers/calc_provider.dart';
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
    String data1Txt = 'userDataEntry';
    String data2Txt = 'userDataPreviewResult';
    final userDataEntrySymbol = ref.watch(userDataEntrySymbolProvider);
    // éste valor puede ser dolares ó la moneda local
    // depende de cuál sea, se hacen unos cálculos
    // en la otra página ó vista

    // String data1Symbol = '\$';
    // String data2Symbol = '\$';

    return PantallaVisualizacion(
      child: DataWidgetView(
        crossAxisAlignment: CrossAxisAlignment.end,
        data1: DataWidget(txt: '$data1Txt $userDataEntrySymbol'),
        data2: DataWidget(txt: '$data2Txt $userDataEntrySymbol'),
      ),
    );
  }
}
