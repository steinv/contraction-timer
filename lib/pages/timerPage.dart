import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../components/contraction.dart';
import '../components/drawer.dart';
import '../components/timerText.dart';
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
            onPressed:
                _contractions.isEmpty
                    ? null
                    : () {
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
        child:
            _contractions.isEmpty
                ? Center(child: Text(AppLocalizations.of(context)!.guidingText))
                : Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 3, child: Center(child: Text(AppLocalizations.of(context)!.headerTime))),
                        Expanded(flex: 4, child: Center(child: Text(AppLocalizations.of(context)!.headerDuration))),
                        Expanded(flex: 5, child: Text(AppLocalizations.of(context)!.headerFrequence)),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _contractions.length,
                        itemBuilder: (context, index) {
                          int nmbr = _contractions.length - index;
                          return _buildTimelineTile(
                            context: context,
                            indicator: _BulletPoint(text: '$nmbr'),
                            contraction: _contractions.reversed.toList()[index],
                            lineUnder: nmbr != 1,
                            lineAbove: true,
                          );
                        },
                      ),
                    ),
                  ],
                ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton:
          _contractions.isNotEmpty && _contractions.last.isOngoing()
              ? FloatingActionButton.extended(
                onPressed: () {
                  setState(() => _contractions.last.endContraction());
                },
                tooltip: 'Stop',
                icon: const Icon(Icons.stop),
                label: const Text('Stop'),
                backgroundColor: Theme.of(context).colorScheme.error,
                foregroundColor: Theme.of(context).colorScheme.onError,
              )
              : FloatingActionButton.extended(
                onPressed: () {
                  setState(() => _contractions.add(Contraction(DateTime.now())));
                },
                tooltip: 'Start',
                backgroundColor: Colors.green[600],
                icon: const Icon(Icons.start),
                label: const Text('Start'),
              ),
    );
  }

  TimelineTile _buildTimelineTile({
    required BuildContext context,
    required _BulletPoint indicator,
    required Contraction contraction,
    bool lineUnder = false,
    bool lineAbove = false,
  }) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.3,
      hasIndicator: true,
      afterLineStyle: LineStyle(color: Theme.of(context).colorScheme.primary.withAlpha(200)),
      beforeLineStyle: LineStyle(color: Theme.of(context).colorScheme.primary.withAlpha(200)),
      isFirst: !lineAbove,
      isLast: !lineUnder,
      indicatorStyle: IndicatorStyle(indicatorXY: 0.5, drawGap: false, width: 30, height: 30, indicator: indicator),
      startChild: Center(child: Text(DateFormat('HH:mm').format(contraction.start))),
      endChild: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 25, bottom: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            contraction.isOngoing()
                ? TimerText(contraction: contraction)
                : InkWell(
                  onTap:
                      () => showDurationPicker(context: context, initialTime: contraction.duration, baseUnit: BaseUnit.second).then((result) {
                        if (result != null) {
                          setState(() => contraction.end = contraction.start.add(result));
                        }
                      }),
                  child: Row(children: [Text('$contraction'), Icon(Icons.arrow_drop_down)]),
                ),
            contraction.isOngoing()
                ? Row()
                : Row(
                  children: [
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
                ),
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
