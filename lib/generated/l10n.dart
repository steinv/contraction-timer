// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Contraction timer - Infans`
  String get applicationTitle {
    return Intl.message(
      'Contraction timer - Infans',
      name: 'applicationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Frequence`
  String get headerFrequence {
    return Intl.message(
      'Frequence',
      name: 'headerFrequence',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get headerTime {
    return Intl.message(
      'Time',
      name: 'headerTime',
      desc: '',
      args: [],
    );
  }

  /// `Duration`
  String get headerDuration {
    return Intl.message(
      'Duration',
      name: 'headerDuration',
      desc: '',
      args: [],
    );
  }

  /// `Press start on your first contraction`
  String get guidingText {
    return Intl.message(
      'Press start on your first contraction',
      name: 'guidingText',
      desc: '',
      args: [],
    );
  }

  /// `Contraction timer`
  String get drawerTimer {
    return Intl.message(
      'Contraction timer',
      name: 'drawerTimer',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get drawerHistory {
    return Intl.message(
      'History',
      name: 'drawerHistory',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get actionDelete {
    return Intl.message(
      'Delete',
      name: 'actionDelete',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get actionContinue {
    return Intl.message(
      'Continue',
      name: 'actionContinue',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get actionCancel {
    return Intl.message(
      'Cancel',
      name: 'actionCancel',
      desc: '',
      args: [],
    );
  }

  /// `Delete contraction`
  String get deleteContractionDialogTitle {
    return Intl.message(
      'Delete contraction',
      name: 'deleteContractionDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this contraction?`
  String get deleteContractionDialogDescription {
    return Intl.message(
      'Are you sure you want to delete this contraction?',
      name: 'deleteContractionDialogDescription',
      desc: '',
      args: [],
    );
  }

  /// `Clear contraction data`
  String get resetDialogTitle {
    return Intl.message(
      'Clear contraction data',
      name: 'resetDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Clear the current contraction data. The data will remain available in the history.`
  String get resetDialogDescription {
    return Intl.message(
      'Clear the current contraction data. The data will remain available in the history.',
      name: 'resetDialogDescription',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'nl'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
