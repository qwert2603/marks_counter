import 'package:flutter/material.dart';
import 'package:marks_counter_flutter/marks_state.dart';
import 'package:marks_counter_flutter/util.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final marksState = context.watch<MarksState>();
    final l10n = context.l10n;
    return AlertDialog(
      title: Text(l10n.settings),
      content: SwitchListTile(
        value: marksState.isOneEnabled,
        onChanged: marksState.setOneEnabled,
        title: Text(l10n.markOne),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.ok),
        ),
      ],
    );
  }
}

class GoodJobDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AlertDialog(
      title: Text(l10n.aboutTitle),
      content: Text(l10n.aboutMessage),
      actions: [
        TextButton(
          onPressed: () async {
            Navigator.pop(context);
            if (await canLaunch(URL_GOOD_JOB)) {
              await launch(URL_GOOD_JOB);
            }
          },
          child: Text(l10n.textGoodJob),
        ),
      ],
    );
  }
}
