import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../components/contraction.dart';
import '../components/drawer.dart';
import '../components/timerText.dart';
import '../dialog/editDialog.dart';
import '../dialog/confirmDialog.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  final List<Contraction> _contractions = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.applicationTitle),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              String title = AppLocalizations.of(context)!.resetDialogTitle;
              String description = AppLocalizations.of(context)!.resetDialogDescription;
              confirmDialog(context, title, description).then((result) {
                if (result == true) {
                  setState(() {
                    // TODO keep history
                    _contractions.clear();
                  });
                }
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
                  setState(() => _contractions.add(Contraction(DateTime.now())));
                },
                tooltip: 'Start',
                backgroundColor: Colors.green[600],
                child: const Icon(Icons.start),
              ),
    );
  }

  TimelineTile _buildTimelineTile({
    required BuildContext context,
    required _BulletPoint indicator,
    required Contraction contraction,
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
        padding: const EdgeInsets.only(left: 16, right: 16, top: 25, bottom: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            contraction.isOngoing() ? TimerText(contraction: contraction) : Text('$contraction'),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    editDialog(context, contraction);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    String title = AppLocalizations.of(context)!.deleteContractionDialogTitle;
                    String description = AppLocalizations.of(context)!.deleteContractionDialogDescription;
                    confirmDialog(context, title, description).then((result) {
                      if (result == true) {
                        setState(() {
                          _contractions.remove(contraction);
                        });
                      }
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
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
