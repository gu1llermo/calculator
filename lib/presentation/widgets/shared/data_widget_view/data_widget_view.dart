import 'package:flutter/material.dart';

class DataWidgetView extends StatelessWidget {
  const DataWidgetView({
    super.key,
    required this.crossAxisAlignment,
    required this.data1,
    required this.data2,
  });
  final CrossAxisAlignment crossAxisAlignment;
  final Widget data1;
  final Widget data2;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        data1, data2,
        // SingleChildScrollView(scrollDirection: Axis.horizontal, child: data1),
        // SingleChildScrollView(scrollDirection: Axis.horizontal, child: data2),
      ],
    );
  }
}
