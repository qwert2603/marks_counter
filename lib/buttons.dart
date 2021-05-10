import 'package:flutter/material.dart';
import 'package:marks_counter_flutter/marks_state.dart';
import 'package:marks_counter_flutter/util.dart';
import 'package:provider/provider.dart';

class MarkButton extends StatelessWidget {
  final int mark;

  MarkButton({required this.mark});

  @override
  Widget build(BuildContext context) {
    return StadiumButton(
      text: "$mark",
      borderColor: MarkColor.MARK[mark]!,
      onPressed: () => context.read<MarksState>().addMark(mark),
    );
  }
}

class StadiumButton extends StatelessWidget {
  final String text;
  final Color borderColor;
  final Function() onPressed;

  StadiumButton({
    required this.text,
    required this.borderColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.all(20),
            textStyle: TextStyle(
              fontSize: 20,
            ),
            side: BorderSide(color: borderColor),
            shape: StadiumBorder(),
            primary: borderColor,
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontFamily: FONT_FAMILY,
            ),
          ),
        ),
      ),
    );
  }
}
