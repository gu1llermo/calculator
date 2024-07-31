import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DataWidget extends ConsumerWidget {
  const DataWidget({
    required this.txt,
    required this.scrollController,
    this.color = Colors.white,
    this.fontSize = 32,
    super.key,
  });
  final String txt;
  final ScrollController scrollController;
  final Color color;
  final double fontSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = TextStyle(
      //color: color,
      fontSize: fontSize,
    );

    return SingleChildScrollView(
      controller: scrollController,
      scrollDirection: Axis.horizontal,
      child: Text(maxLines: 1, txt, style: textStyle),
    );
  }
}
