import 'package:flutter_test/flutter_test.dart';
import 'package:marks_counter_flutter/marks_state.dart';
import 'package:marks_counter_flutter/repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test("marks", () async {
    // test corrupted storage.
    SharedPreferences.setMockInitialValues({RepoImpl.KEY_MARKS: "q1 23h45f"});
    final prefs = await SharedPreferences.getInstance();
    final repo = RepoImpl(prefs);
    final marksState = MarksState(repo);

    expect(marksState.averageText(), "3.00");
    expect(marksState.formatMarks(), "1234 5");

    marksState.clear();
    expect(marksState.averageText(), "n/a");
    expect(marksState.formatMarks(), "_");
    expect(<int>[], repo.getMarks());

    marksState.removeMark();
    expect(marksState.averageText(), "n/a");
    expect(marksState.formatMarks(), "_");

    marksState.clear();
    expect(marksState.averageText(), "n/a");
    expect(marksState.formatMarks(), "_");

    marksState.addMark(3);
    expect(marksState.averageText(), "3.00");
    expect(marksState.formatMarks(), "3");
    expect([3], repo.getMarks());

    marksState.addMark(4);
    expect(marksState.averageText(), "3.50");
    expect(marksState.formatMarks(), "34");

    marksState.addMark(5);
    marksState.addMark(5);
    expect(marksState.averageText(), "4.25");
    expect(marksState.formatMarks(), "3455");

    marksState.addMark(2);
    expect(marksState.averageText(), "3.80");
    expect(marksState.formatMarks(), "3455 2");

    marksState.addMark(3);
    expect(marksState.averageText(), "3.67");
    expect(marksState.formatMarks(), "3455 23");

    marksState.removeMark();
    expect(marksState.formatMarks(), "3455 2");

    marksState.removeMark();
    expect(marksState.formatMarks(), "3455");

    marksState.removeMark();
    expect(marksState.formatMarks(), "345");

    marksState.addMark(2);
    marksState.addMark(3);
    marksState.addMark(4);
    marksState.addMark(5);
    expect(marksState.formatMarks(), "3452 345");

    marksState.clear();
    expect(marksState.formatMarks(), "_");

    marksState.addMark(2);
    marksState.addMark(3);
    marksState.addMark(4);
    marksState.addMark(5);
    marksState.addMark(3);
    marksState.addMark(4);
    marksState.addMark(5);
    marksState.addMark(2);
    marksState.addMark(5);
    marksState.addMark(5);
    expect(marksState.formatMarks(), "2345 3452 55");
    expect([2, 3, 4, 5, 3, 4, 5, 2, 5, 5], repo.getMarks());
  });
}
