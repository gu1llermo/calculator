import 'package:calculator_app/services/local_storage/local_keys.dart';
import 'package:calculator_app/services/local_storage/local_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// const String monedaBase = '\$';
const double tasaGeneralInitValue = 40.0;

final tasaGeneralProvider = StateProvider<double>((ref) =>
    LocalStorage.prefs.getDouble(LocalKeys.tasaGeneral) ??
    tasaGeneralInitValue);

final indiceShapeProvider = StateProvider<int>(
    (ref) => LocalStorage.prefs.getInt(LocalKeys.indiceShape) ?? 1);

final symbolMonedaLocalProvider = StateProvider<String>(
    (ref) => LocalStorage.prefs.getString(LocalKeys.symbolMonedaLocal) ?? 'Bs');

final monedaBaseProvider = StateProvider<String>(
    (ref) => LocalStorage.prefs.getString(LocalKeys.monedaBase) ?? '\$');

final userDataEntrySymbolProvider = StateProvider<String>((ref) =>
    LocalStorage.prefs.getString(LocalKeys.userDataEntrySymbol) ?? 'Bs');

final userDataEntryProvider = StateProvider<String>(
    (ref) => LocalStorage.prefs.getString(LocalKeys.userDataEntry) ?? '');

final userDataPreviewResultProvider = StateProvider<String>((ref) =>
    LocalStorage.prefs.getString(LocalKeys.userDataPreviewResult) ?? '');

final historialProvider =
    NotifierProvider<HistorialNotifier, List<String>>(HistorialNotifier.new);

class HistorialNotifier extends Notifier<List<String>> {
  @override
  build() => LocalStorage.prefs.getStringList(LocalKeys.historial) ?? [];

  void add(String title, String subtitle) {
    final String txt = '$title $subtitle';

    state = [txt, ...state];
    LocalStorage.prefs.setStringList(LocalKeys.historial, state);
  }

  void clear() {
    state = [];
    LocalStorage.prefs.setStringList(LocalKeys.historial, state);
  }
}
