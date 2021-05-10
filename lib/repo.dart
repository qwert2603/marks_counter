import 'package:shared_preferences/shared_preferences.dart';

abstract class Repo {
  List<int> getMarks();

  void saveMarks(List<int> marks);

  bool isOneEnabled();

  void setOneEnabled(bool enabled);

  bool isDark();

  void setDark(bool dark);

  int getLocaleIndex();

  void setLocaleIndex(int index);
}

class RepoImpl implements Repo {
  static const KEY_MARKS = "KEY_MARKS";
  static const KEY_ONE_ENABLED = "KEY_ONE_ENABLED";
  static const KEY_DARK = "KEY_DARK";
  static const KEY_LOCALE_INDEX = "KEY_LOCALE_INDEX";

  final SharedPreferences _prefs;

  RepoImpl(this._prefs);

  @override
  List<int> getMarks() => (_prefs.getString(KEY_MARKS) ?? "")
      .split("")
      .map(int.tryParse)
      .where((e) => e != null)
      .map((e) => e as int)
      .toList();

  @override
  void saveMarks(List<int> marks) {
    final s = marks.fold<String>("", (s, m) => s + "$m");
    _prefs.setString(KEY_MARKS, s);
  }

  @override
  bool isOneEnabled() => _prefs.getBool(KEY_ONE_ENABLED) ?? false;

  @override
  void setOneEnabled(bool enabled) {
    _prefs.setBool(KEY_ONE_ENABLED, enabled);
  }

  @override
  bool isDark() => _prefs.getBool(KEY_DARK) ?? false;

  @override
  void setDark(bool dark) {
    _prefs.setBool(KEY_DARK, dark);
  }

  @override
  int getLocaleIndex() => _prefs.getInt(KEY_LOCALE_INDEX) ?? 0;

  @override
  void setLocaleIndex(int index) {
    _prefs.setInt(KEY_LOCALE_INDEX, index);
  }
}
