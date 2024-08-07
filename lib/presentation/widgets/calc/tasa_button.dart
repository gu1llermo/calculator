import 'package:calculator_app/config/helpers/tools.dart';
import 'package:calculator_app/presentation/providers/calc_provider.dart';
import 'package:calculator_app/services/local_storage/local_keys.dart';
import 'package:calculator_app/services/local_storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TasaButton extends ConsumerStatefulWidget {
  const TasaButton({super.key, this.width = 200.0});
  final double width;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TasaButtonState();
}

class _TasaButtonState extends ConsumerState<TasaButton> {
  bool _isError = false;
  String _errorMsg = '';

  late FocusNode _focusNode;
  late TextEditingController _tasaEditController;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    final tasaGeneral = ref.read(tasaGeneralProvider);
    final tasaGeneralTxt = Tools.eliminaDecimalCero(tasaGeneral);
    _tasaEditController = TextEditingController(text: tasaGeneralTxt);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _tasaEditController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fontSizeLabel = Theme.of(context).textTheme.bodyLarge?.fontSize;
    final labelTextStyle = TextStyle(
        // color: Colors.white,
        fontSize: fontSizeLabel,
        fontWeight: FontWeight.bold);

    final symbolMonedaLocal = ref.watch(symbolMonedaLocalProvider);
    final monedaBase = ref.watch(monedaBaseProvider);

    return TextField(
      style: labelTextStyle,
      textAlign: TextAlign.right,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'\d+\.?\d*'))
      ],
      keyboardType: TextInputType.number,
      focusNode: _focusNode,
      controller: _tasaEditController,
      onTapOutside: (event) {
        final value = _tasaEditController.text;

        if (value.isEmpty) {
          // porque no se puede ingresar un valor vacío
          _showError('Debe ingresar un valor');
          return;
        }
        final tasaGeneral = double.parse(value);
        if (tasaGeneral <= 0) {
          // la tasa tiene que ser mayor que 0
          _showError('La tasa debe ser > 0');
          return;
        }
        // si llega hasta aquí es que no es vacío ni 0

        _tasaEditController.text = Tools.eliminaDecimalCero(tasaGeneral);
        _focusNode.unfocus();

        _updateTasaGeneral(tasaGeneral);
      },
      onSubmitted: (value) {
        if (value.isEmpty) {
          // porque no se puede ingresar un valor vacío
          _showError('Debe ingresar un valor');
          _focusNode.requestFocus();
          return;
        }
        final tasaGeneral = double.parse(value);
        if (tasaGeneral <= 0) {
          // la tasa tiene que ser mayor que 0
          _showError('La tasa debe ser > 0');
          _focusNode.requestFocus();
          return;
        }

        // si llega hasta aquí es que no es vacío ni 0
        _tasaEditController.text = Tools.eliminaDecimalCero(tasaGeneral);
        _updateTasaGeneral(tasaGeneral);
      },
      decoration: InputDecoration(
        border: UnderlineInputBorder(borderRadius: BorderRadius.circular(20)),
        error: _isError
            ? Text(_errorMsg, style: const TextStyle(color: Colors.red))
            : null,
        labelText: 'Tasa, 1$monedaBase equivale a:',
        labelStyle: labelTextStyle,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffix: Text(symbolMonedaLocal),
        suffixStyle: labelTextStyle,
        filled: true,
        fillColor: Colors.black26,
        // constraints: BoxConstraints.tightFor(
        //   width: widget.width,
        // ),
      ),
    );
  }

  void _updateTasaGeneral(double tasaGeneral) {
    _isError = false;
    // actualiza a tasaGeneral
    ref.read(tasaGeneralProvider.notifier).update((state) {
      // pero hay que guardar éste valor en SharedPreferences
      LocalStorage.prefs.setDouble(LocalKeys.tasaGeneral, tasaGeneral);
      return tasaGeneral;
    });
    refresh();
  }

  void refresh() {
    if (!mounted) return; // claro aquí no tengo contemplado que esto pase, pero
    // lo coloco para acordarme que así me garantizo que se refresque solo cuando esté montado el estado del widget

    setState(() {});
  }

  void _showError(String errorMsg) {
    _errorMsg = errorMsg;
    _isError = true;
    refresh();
  }
}
