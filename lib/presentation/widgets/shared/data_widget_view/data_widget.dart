import 'package:flutter/material.dart';

class DataWidget extends StatelessWidget {
  const DataWidget({
    super.key,
    required this.txt,
  });
  final String txt;

  @override
  Widget build(BuildContext context) {
    final double fontSize =
        Theme.of(context).textTheme.displaySmall?.fontSize ?? 30;

    final textStyle = TextStyle(color: Colors.white, fontSize: fontSize);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Text(maxLines: 1, txt, style: textStyle),
    );
  }
}
