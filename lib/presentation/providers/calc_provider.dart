import 'package:calculator_app/services/local_storage/local_keys.dart';
import 'package:calculator_app/services/local_storage/local_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const double tasaGeneralInitValue = 1.0;
final tasaGeneralProvider = StateProvider<double>((ref) =>
    LocalStorage.prefs.getDouble(LocalKeys.tasaGeneral) ??
    tasaGeneralInitValue);
