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

  static String eliminaDecimalCeroFromTxt(String nroTxt) {
    try {
      final nroDouble = double.parse(nroTxt);
      final fractionalPart = nroDouble % 1;

      if (fractionalPart == 0) {
        final index = nroTxt.indexOf('.');
        return nroTxt.substring(0, index);
      }
    } catch (e) {
      // si ocurrer un error simplemente regresa su valor tal cual
    }

    return nroTxt;
  }
}
