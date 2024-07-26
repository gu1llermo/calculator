import 'package:calculator_app/services/local_storage/local_keys.dart';
import 'package:calculator_app/services/local_storage/local_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const String monedaBase = '\$';
const double tasaGeneralInitValue = 1.0;
final tasaGeneralProvider = StateProvider<double>((ref) =>
    LocalStorage.prefs.getDouble(LocalKeys.tasaGeneral) ??
    tasaGeneralInitValue);

final indiceShapeProvider = StateProvider<int>(
    (ref) => LocalStorage.prefs.getInt(LocalKeys.indiceShape) ?? 0);

final symbolMonedaLocalProvider = StateProvider<String>(
    (ref) => LocalStorage.prefs.getString(LocalKeys.symbolMonedaLocal) ?? 'Bs');

final userDataEntrySymbolProvider = StateProvider<String>((ref) =>
    LocalStorage.prefs.getString(LocalKeys.userDataEntrySymbol) ?? '\$');
