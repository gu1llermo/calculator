import 'package:flutter/material.dart';

class PantallaVisualizacion extends StatelessWidget {
  final Widget child;
  const PantallaVisualizacion({super.key, this.child = const Placeholder()});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          width: double.infinity, // iba double.infinity
          decoration: BoxDecoration(
              color: Colors.black12, borderRadius: BorderRadius.circular(20)),
          child: child,
        ),
      ),
    );
  }
}
