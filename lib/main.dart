import 'package:contractions/pages/disclaimerPage.dart';
import 'package:contractions/pages/historyPage.dart';
import 'package:contractions/pages/timerPage.dart';
import 'package:duration_picker/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ContractionsApp());
}

class ContractionsApp extends StatelessWidget {
  const ContractionsApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.applicationTitle,
      //theme: ThemeData(useMaterial3: false, primarySwatch: Colors.pink, brightness: Brightness.light),
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.light(
          primary: Colors.pink[300]!,
          // Use a lighter shade of pink
          onPrimary: Colors.white,
          // Text color on primary color
          secondary: Colors.pink[200]!,
          // Lighter secondary color
          onSecondary: Colors.black,
          // Text color on background
          surface: Colors.white,
          // Lighter surface color
          onSurface: Colors.black,
          // Text color on surface
          error: Colors.red,
          // Error color
          onError: Colors.white, // Text color on error
        ), // Light mode
      ),
      darkTheme: ThemeData(useMaterial3: true, brightness: Brightness.dark, colorSchemeSeed: Colors.pink),
      localizationsDelegates: [DurationPickerLocalizations.delegate, ...AppLocalizations.localizationsDelegates],
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: '/',
      routes: {'/': (context) => DisclaimerPage(), '/timer': (context) => TimerPage(), '/history': (context) => Historypage()},
    );
  }
}
