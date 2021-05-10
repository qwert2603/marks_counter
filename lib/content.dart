import 'package:flutter/material.dart';
import 'package:marks_counter_flutter/buttons.dart';
import 'package:marks_counter_flutter/marks_state.dart';
import 'package:marks_counter_flutter/util.dart';
import 'package:provider/provider.dart';

class MarksOutput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final marksState = context.watch<MarksState>();
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              l10n.average,
              style: TextStyle(fontSize: 26),
            ),
            SizedBox(width: 2),
            Text(
              marksState.averageText(),
              style: TextStyle(
                color: marksState.averageColor(),
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 24),
        Text(
          marksState.formatMarks(),
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}

class MarkButtonsBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final marksState = context.watch<MarksState>();
    final l10n = context.l10n;
    return Column(
      children: [
        Row(
          children: [
            // todo: animate button hide/show
            if (marksState.isOneEnabled) MarkButton(mark: 1),
            MarkButton(mark: 2),
            MarkButton(mark: 3),
            MarkButton(mark: 4),
            MarkButton(mark: 5),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            StadiumButton(
              text: l10n.removeLast,
              borderColor: Theme.of(context).colorScheme.onSurface,
              onPressed: () => marksState.removeMark(),
            ),
            StadiumButton(
              text: l10n.clear,
              borderColor: Theme.of(context).colorScheme.onSurface,
              onPressed: () => marksState.clear(),
            ),
          ],
        ),
      ],
    );
  }
}
