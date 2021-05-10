import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension BuildContextX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

class MarkColor {
  static const MARK = <int, Color>{
    1: Color(0xff9a0000),
    2: Color(0xfffa0000),
    3: Color(0xffefca35),
    4: Color(0xff00df00),
    5: Color(0xffef0fe0),
  };

  static const MARK_DRAW_LIGHT = Color(0xff707070);
  static const MARK_DRAW_DARK = Color(0xffb0b0b0);
}

const ANIMATION_DURATION = Duration(seconds: 1);

const URL_GOOD_JOB =
    "https://play.google.com/store/apps/details?id=com.qwert2603.good_job";

const FONT_FAMILY = "google_sans";