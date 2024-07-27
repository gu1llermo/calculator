import 'package:math_expressions/math_expressions.dart';

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

  static String redondeaDecimalesFromTxt(String nroTxt, int decimales) {
    if (!nroTxt.contains('.')) {
      return nroTxt; // si no contiene . entonces que finalice regresando su valor
    }
    // pero si tiene punto enotnces vamos a formatearlo
    try {
      final nro = double.parse(nroTxt);

      return nro.toStringAsFixed(decimales);
    } catch (e) {
      // si ocurrer un error simplemente regresa su valor tal cual
    }

    return nroTxt;
  }

  static String calculate(String userInput) {
    // Infinity : cuando se divide por 0
    // RangeError cuando no está completamente bien armada la expresión
    // por ejemplo escriben 5+ y quieren un resultado
    // ó escriben 5+*-+*/ cosas así

    // FormatException no debería aparecer, pero aparece cuando permites
    // armar mal una expresión

    try {
      final expression = Parser().parse(userInput);
      final evaluation =
          expression.evaluate(EvaluationType.REAL, ContextModel());
      print('evaluation= $evaluation');
      return evaluation.toString();
    } on RangeError {
      return 'RangeError';
    } catch (e) {
      // print('e -> $e');
      // e -> RangeError (index): Invalid value: Valid value range is empty: -1
      // es por faltan argumentos, por ejemplo 1+ y le damos enter
      return e
          .toString(); // no debería llegar aquí nunca, porque tengo que controlar bien las entradas
    }
  }
}
