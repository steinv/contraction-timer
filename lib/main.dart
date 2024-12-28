import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

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
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent), useMaterial3: true),
      darkTheme: ThemeData(useMaterial3: true, brightness: Brightness.dark, colorSchemeSeed: Colors.pink),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: TimerPage(),
    );
  }
}

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  final List<_Contraction> _contractions = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      drawer: _buildDrawer(context),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.applicationTitle),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                // TODO keep history
                // TODO popup
                _contractions.clear();
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: _contractions.length,
          itemBuilder: (context, index) {
            return _buildTimelineTile(
              context: context,
              indicator: _BulletPoint(text: (index + 1).toString()),
              contraction: _contractions[index],
              isFirst: index == 0,
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton:
          _contractions.isNotEmpty && _contractions.last.isOngoing()
              ? FloatingActionButton(
                onPressed: () {
                  setState(() => _contractions.last.endContraction());
                },
                tooltip: 'Stop',
                backgroundColor: Colors.red.shade600,
                child: const Icon(Icons.stop),
              )
              : FloatingActionButton(
                onPressed: () {
                  setState(() => _contractions.add(_Contraction(DateTime.now())));
                },
                tooltip: 'Start',
                backgroundColor: Colors.green[600],
                child: const Icon(Icons.start),
              ),
    );
  }
}

Drawer _buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        ListTile(
          leading: const Icon(Icons.timer),
          title: Text(AppLocalizations.of(context)!.drawerTimer),
          selected: true,
          onTap: () {
            // TODO
          },
        ),
        ListTile(
          leading: const Icon(Icons.history),
          title: Text(AppLocalizations.of(context)!.drawerHistory),
          onTap: () {
            // TODO
          },
        ),
      ],
    ),
  );
}

class _Contraction {
  final DateTime start;
  late DateTime? end;
  final Stopwatch _stopwatch;

  _Contraction(this.start) : _stopwatch = Stopwatch()..start();

  bool isOngoing() {
    return _stopwatch.isRunning;
  }

  void endContraction() {
    _stopwatch.stop();
    end = DateTime.now();
  }

  Duration getTimeSince(_Contraction newContraction) {
    return end != null ? end!.difference(newContraction.start) : const Duration();
  }

  Duration get duration {
    return _stopwatch.elapsed;
  }

  String getDurationFormatted() {
    return [duration.inMinutes, duration.inSeconds].map((seg) => seg.remainder(60).toString().padLeft(2, '0')).join(':');
  }
}

TimelineTile _buildTimelineTile({
  required BuildContext context,
  required _BulletPoint indicator,
  required _Contraction contraction,
  bool isFirst = false,
  bool isLast = false,
}) {
  return TimelineTile(
    alignment: TimelineAlign.manual,
    lineXY: 0.3,
    beforeLineStyle: LineStyle(color: Theme.of(context).colorScheme.primary.withAlpha(200)),
    indicatorStyle: IndicatorStyle(indicatorXY: 0.5, drawGap: true, width: 30, height: 30, indicator: indicator),
    isLast: isLast,
    isFirst: isFirst,
    startChild: Center(child: Text(DateFormat('HH:mm').format(contraction.start))),
    endChild: Container(
      // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
      padding: const EdgeInsets.only(left: 16, right: 16, top: 25, bottom: 25),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
        _TimerText(contraction: contraction),
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            // TODO edit contraction
          },
        ),
      ]),
    ),
  );
}

class _BulletPoint extends StatelessWidget {
  const _BulletPoint({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).colorScheme.primary)),
        Positioned.fill(
          child: Align(alignment: Alignment.center, child: Text(text, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary))),
        ),
      ],
    );
  }
}

class _TimerText extends StatefulWidget {
  final _Contraction contraction;

  const _TimerText({required this.contraction});

  @override
  State<_TimerText> createState() => _TimerTextState();
}

class _TimerTextState extends State<_TimerText> {
  late _Contraction contraction;
  late Timer timer;

  _TimerTextState();

  @override
  void initState() {
    contraction = widget.contraction;
    timer = Timer.periodic(const Duration(milliseconds: 30), callback);
    super.initState();
  }

  void callback(Timer timer) {
    if (contraction.isOngoing()) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(contraction.getDurationFormatted());
  }
}
