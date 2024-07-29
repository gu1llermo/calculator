import 'package:flutter/material.dart';

const Icon iconHistory = Icon(
  Icons.history_rounded,
  color: Colors.white,
  size: 30,
);

class HistoryButton extends StatelessWidget {
  const HistoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: () {}, icon: iconHistory);
  }
}
