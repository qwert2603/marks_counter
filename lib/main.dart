import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:marks_counter_flutter/app_bar.dart';
import 'package:marks_counter_flutter/content.dart';
import 'package:marks_counter_flutter/marks_state.dart';
import 'package:marks_counter_flutter/repo.dart';
import 'package:marks_counter_flutter/util.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final Repo repo = RepoImpl(prefs);
  runApp(
    ChangeNotifierProvider(
      create: (_) => MarksState(repo),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final marksState = context.watch<MarksState>();
    final color = Colors.red;
    return MaterialApp(
      title: 'Marks Counter',
      onGenerateTitle: (context) => context.l10n.appName,
      theme: ThemeData(
        brightness: marksState.isDark ? Brightness.dark : Brightness.light,
        primarySwatch: color,
        accentColor: color,
        toggleableActiveColor: color,
        fontFamily: FONT_FAMILY,
        typography: Typography.material2018(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: AppLocalizations.supportedLocales[marksState.localeIndex],
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            MarksAppBar(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  // Expanded(flex: 1, child: Container()),
                  MarksOutput(),
                  // todo: animate when formatted marks take 1->2 lines.
                  SizedBox(height: 20),
                  MarkButtonsBar(),
                  // Expanded(flex: 5, child: Container()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
