
import 'dart:async';

import 'package:flutter/material.dart';

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
    if (!contraction.isOngoing()) {
      timer.cancel();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Text('$contraction');
  }
}
