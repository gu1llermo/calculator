import 'package:calculator_app/config/helpers/tools.dart';
import 'package:calculator_app/presentation/providers/calc_provider.dart';
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
  late ScrollController _data1ScrollController;
  late ScrollController _data2ScrollController;

  @override
  void initState() {
    super.initState();
    _data1ScrollController = ScrollController();
    _data2ScrollController = ScrollController();
  }

  @override
  void dispose() {
    _data1ScrollController.dispose();
    _data2ScrollController.dispose();
    super.dispose();
  }

  void autoScroll() async {
    if (!_data1ScrollController.hasClients) return;

    await Future.delayed(const Duration(milliseconds: 400));

    _data1ScrollController.position.moveTo(0);

    _data2ScrollController.position.moveTo(0);
  }

  @override
  Widget build(BuildContext context) {
    // éstso valores dependen de cuál moneda tiene el ususario de entrada
    final userDataEntry = ref.watch(userDataEntryProvider);
    final userDataEntrySymbol = ref.watch(userDataEntrySymbolProvider);

    final symbolMonedaLocal =
        ref.watch(symbolMonedaLocalProvider); // aquí la moneda local
    // es fija, pero igual lo hago así para que sea flexible el código a futuro

    String result =
        userDataEntry.isNotEmpty ? Tools.calculate(userDataEntry) : '';
    // Infinity : cuando se divide por 0
    // RangeError cuando no está completamente bien armada la expresión
    // por ejemplo escriben 5+ y quieren un resultado
    // ó escriben 5+*-+*/ cosas así

    // FormatException no debería aparecer, pero aparece cuando permites
    // armar mal una expresión

    String data1Txt = 'Parte Entera Dollar';
    String data2Txt = 'Restante en Moneda Local';
    // aquí siempre es la moneda base, en éstos casos es el dólar
    // y lo estoy dejando fijo para simplificar

    autoScroll();

    return PantallaVisualizacion(
      child: DataWidgetView(
        crossAxisAlignment: CrossAxisAlignment.start,
        data1: DataWidget(
          txt: '$monedaBase $data1Txt',
          scrollController: _data1ScrollController,
        ),
        data2: DataWidget(
          txt: '$symbolMonedaLocal $data2Txt',
          scrollController: _data2ScrollController,
        ),
      ),
    );
  }
}
