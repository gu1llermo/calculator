import 'package:flutter/material.dart';

class DataWidget extends StatelessWidget {
  const DataWidget({
    super.key,
    required this.alignment,
    required this.data1,
    required this.data2,
  });
  final Alignment alignment;
  final Widget data1;
  final Widget data2;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitHeight,
      alignment: alignment,
      child: Column(
        children: [
          data1,
          data2,
        ],
      ),
    );
  }
}
