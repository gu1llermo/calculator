import 'package:flutter/material.dart';

class DataWidget extends StatelessWidget {
  const DataWidget({
    super.key,
    required this.txt,
  });
  final String txt;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.white,
      fontSize: 38,
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Text(maxLines: 1, txt, style: textStyle),
    );
  }
}
