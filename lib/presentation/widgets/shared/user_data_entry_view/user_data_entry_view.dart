import 'package:calculator_app/config/helpers/tools.dart';
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
  late ScrollController _userDataEntryScrollController;
  late ScrollController _userDataPreviewResultScrollController;

  @override
  void initState() {
    super.initState();
    _userDataEntryScrollController = ScrollController();
    _userDataPreviewResultScrollController = ScrollController();
  }

  @override
  void dispose() {
    _userDataEntryScrollController.dispose();
    _userDataPreviewResultScrollController.dispose();
    super.dispose();
  }

  void autoScroll() async {
    if (!_userDataEntryScrollController.hasClients) return;

    await Future.delayed(const Duration(milliseconds: 400));

    final userDataEntryMaxScrollExtent =
        _userDataEntryScrollController.position.maxScrollExtent;
    _userDataEntryScrollController.position
        .moveTo(userDataEntryMaxScrollExtent);

    final userDataPreviewResultMaxScrollExtent =
        _userDataPreviewResultScrollController.position.maxScrollExtent;
    _userDataPreviewResultScrollController.position
        .moveTo(userDataPreviewResultMaxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    final userDataEntry = ref.watch(userDataEntryProvider);
    final userDataPreviewResult = ref.watch(userDataPreviewResultProvider);

    String userDataPreviewResultAux =
        Tools.redondeaDecimalesFromTxt(userDataPreviewResult, 2);
    // me gustaría formatear en caso que haya decimales que sean 0
    userDataPreviewResultAux =
        Tools.eliminaDecimalCeroFromTxt(userDataPreviewResultAux);

    final userDataEntrySymbol = ref.watch(userDataEntrySymbolProvider);

    final symbol1 = userDataEntry.isEmpty ? '' : userDataEntrySymbol;
    final symbol2 = userDataPreviewResult.isEmpty
        ? ''
        : userDataPreviewResult.contains('Error') ||
                userDataPreviewResult.contains('Infinity')
            ? ''
            : userDataEntrySymbol;
    // éste valor puede ser dólares ó la moneda local
    // depende de cuál sea, se hacen unos cálculos
    // en la otra página ó vista
    autoScroll();

    return PantallaVisualizacion(
      child: DataWidgetView(
        crossAxisAlignment: CrossAxisAlignment.end,
        data1: DataWidget(
          txt: '$userDataEntry $symbol1',
          scrollController: _userDataEntryScrollController,
        ),
        data2: DataWidget(
          txt: '$userDataPreviewResultAux $symbol2',
          scrollController: _userDataPreviewResultScrollController,
          color: Colors.white.withOpacity(.7),
          fontSize: 35,
        ),
      ),
    );
  }
}
