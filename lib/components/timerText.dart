import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'contraction.dart';

class TimerText extends StatefulWidget {
  final Contraction contraction;

  const TimerText({super.key, required this.contraction});

  @override
  State<TimerText> createState() => _TimerTextState();
}

class _TimerTextState extends State<TimerText> {
  late Contraction contraction;
  late Timer timer;

  _TimerTextState();

  @override
  void initState() {
    contraction = widget.contraction;
    timer = Timer.periodic(const Duration(milliseconds: 200), callback);
    super.initState();
  }

  void callback(Timer timer) {
    setState(() {});
    if (!contraction.isOngoing()) {
      timer.cancel();
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      Contraction.getDurationFormatted(
        contraction.duration,
        AppLocalizations.of(context)!,
      ),
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }
}
