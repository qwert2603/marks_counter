import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:marks_counter_flutter/repo.dart';
import 'package:marks_counter_flutter/util.dart';

class MarksState extends ChangeNotifier {
  static const MAX_MARKS = 80;
  static const FORMAT_MARKS_GROUP = 4;

  final Repo _repo;

  late final List<int> _marks;
  late bool _isOneEnabled;
  late bool _isDark;
  late int _localeIndex;

  MarksState(this._repo) {
    _marks = _repo.getMarks();
    _isOneEnabled = _repo.isOneEnabled();
    _isDark = _repo.isDark();
    _localeIndex = _repo.getLocaleIndex();
  }

  bool get isOneEnabled => _isOneEnabled;

  bool get isDark => _isDark;

  int get localeIndex => _localeIndex % _localesCount();

  String averageText() {
    final average = _average();
    if (average == null) return "n/a";
    return average.toStringAsFixed(2);
  }

  Color averageColor() {
    final average = _average();
    if (average == null) {
      return _isDark ? Colors.white : Colors.black;
    }
    if (average % 1.0 == 0.5) {
      return _isDark ? MarkColor.MARK_DRAW_DARK : MarkColor.MARK_DRAW_LIGHT;
    }
    return MarkColor.MARK[average.round()]!;
  }

  String formatMarks() {
    if (_marks.isEmpty) return "_";
    final stringBuffer = StringBuffer();
    for (int i = 0; i < _marks.length; ++i) {
      if (i > 0 && i % FORMAT_MARKS_GROUP == 0) stringBuffer.write(" ");
      stringBuffer.write("${_marks[i]}");
    }
    return stringBuffer.toString();
  }

  void addMark(int mark) {
    if (mark < 1 || mark > 5) throw Exception();
    if (_marks.length < MAX_MARKS) {
      _marks.add(mark);
      _onMarksChanged();
    }
  }

  void removeMark() {
    if (_marks.isNotEmpty) {
      _marks.removeLast();
      _onMarksChanged();
    }
  }

  void clear() {
    if (_marks.isNotEmpty) {
      _marks.clear();
      _onMarksChanged();
    }
  }

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
    _repo.setDark(_isDark);
  }

  void setOneEnabled(bool enabled) {
    _isOneEnabled = enabled;
    notifyListeners();
    _repo.setOneEnabled(_isOneEnabled);
  }

  void setNextLocale() {
    _localeIndex = (_localeIndex + 1) % _localesCount();
    notifyListeners();
    _repo.setLocaleIndex(_localeIndex);
  }

  List<int> visibleMarks() => (_isOneEnabled ? [1] : <int>[]) + [2, 3, 4, 5];

  String languageCode() =>
      AppLocalizations.supportedLocales[localeIndex].languageCode;

  double? _average() {
    if (_marks.isEmpty) return null;
    final sum = _marks.fold<int>(0, (s, m) => s + m);
    return sum / _marks.length;
  }

  int _localesCount() => AppLocalizations.supportedLocales.length;

  void _onMarksChanged() {
    notifyListeners();
    _repo.saveMarks(_marks);
  }
}
