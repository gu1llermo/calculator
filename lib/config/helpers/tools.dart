class Tools {
  /// Si  la parte decimal es 0, entonces la elimina, para que no se vea

  static String eliminaDecimalCero(double nro) {
    final nroTxt = nro.toString();
    final fractionalPart = nro % 1;

    if (fractionalPart == 0) {
      final index = nroTxt.indexOf('.');
      return nroTxt.substring(0, index);
    }

    return nroTxt;
  }
}
