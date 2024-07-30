import 'package:calculator_app/presentation/providers/calc_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

const Icon iconHistory = Icon(
  Icons.history_rounded,
  color: Colors.white,
  size: 30,
);

class HistoryButton extends ConsumerStatefulWidget {
  const HistoryButton({super.key, required this.heightFactor});
  final double heightFactor;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HistoryButtonState();
}

class _HistoryButtonState extends ConsumerState<HistoryButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          displayHistorial(context, ref, widget.heightFactor);
        },
        icon: iconHistory);
  }
}

Future<void> displayHistorial(
    BuildContext context, WidgetRef ref, double heightFactor) async {
  final historial = ref.read(historialProvider);

  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: heightFactor,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: historial.length,
                  itemBuilder: (context, index) {
                    final data = historial[index].split(' ');
                    final title = data[0];
                    final subtitle = data[1];
                    return ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      title: Text(
                        title,
                        textAlign: TextAlign.end,
                      ),
                      subtitle: Text(subtitle, textAlign: TextAlign.end),
                    );
                  },
                ),
              ),
              IconButton(
                  onPressed: () {
                    ref.read(historialProvider.notifier).clear();
                    context.pop();
                  },
                  icon: const Icon(Icons.delete_forever_rounded))
            ],
          ),
        );
      });
}
