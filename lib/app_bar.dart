import 'package:flutter/material.dart';
import 'package:marks_counter_flutter/dialogs.dart';
import 'package:marks_counter_flutter/marks_state.dart';
import 'package:provider/provider.dart';

class MarksAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final marksState = context.watch<MarksState>();
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () => showDialog<void>(
              context: context,
              builder: (context) => SettingsDialog(),
            ),
            icon: Icon(Icons.settings),
          ),
          SizedBox(width: 8),
          IconButton(
            onPressed: () => showDialog<void>(
              context: context,
              builder: (context) => GoodJobDialog(),
            ),
            icon: Icon(
              Icons.info_outline,
              color: Theme.of(context).accentColor,
            ),
          ),
          SizedBox(width: 8),
          IconButton(
            onPressed: () => marksState.setNextLocale(),
            icon: Text(
              marksState.languageCode().toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 8),
          IconButton(
            onPressed: () => marksState.toggleTheme(),
            icon: marksState.isDark
                ? const Icon(Icons.brightness_7, color: Colors.yellow)
                : const RotatedBox(
                    quarterTurns: 2,
                    child: Icon(Icons.brightness_2),
                  ),
          ),
        ],
      ),
    );
  }
}
