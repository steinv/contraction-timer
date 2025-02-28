import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../components/contraction.dart';
import '../components/drawer.dart';
import '../components/timerText.dart';
import '../dialog/confirmDialog.dart';

class TimerPage extends StatefulWidget {
  static final String CONTRACTIONS = "contractions_data";

  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  List<Contraction> _contractions = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    _checkForData();
  }

  Future<void> _checkForData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _contractions =
          prefs.getStringList(TimerPage.CONTRACTIONS)?.map((b64) => Contraction.deserialize(b64)).toList(growable: true) ??
          List.empty(growable: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context, 0),
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
                            _contractions.clear();
                            SharedPreferences.getInstance().then((pref) => pref.remove(TimerPage.CONTRACTIONS));
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
                        Expanded(flex: 4, child: Center(child: Text(AppLocalizations.of(context)!.headerTime))),
                        Expanded(flex: 2, child: Container()),
                        Expanded(
                          flex: 10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(AppLocalizations.of(context)!.headerDuration),
                              Text(AppLocalizations.of(context)!.headerFrequence),
                              SizedBox(width: 30), // delete button
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _contractions.length,
                        itemBuilder: (context, index) {
                          int nmbr = _contractions.length - index;
                          var reversedList = _contractions.reversed.toList();
                          return _buildTimelineTile(
                            context: context,
                            indicator: _BulletPoint(text: '$nmbr'),
                            contraction: reversedList[index],
                            previousContraction: index + 1 < _contractions.length ? reversedList[index + 1] : null,
                            nextContraction: index - 1 >= 0 ? reversedList[index - 1] : null,
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
                  SharedPreferences.getInstance().then(
                    (pref) => pref.setStringList(TimerPage.CONTRACTIONS, _contractions.map((c) => c.serialize()).toList(growable: false)),
                  );
                },
                icon: const Icon(Icons.stop),
                label: Text(AppLocalizations.of(context)!.actionStop),
                backgroundColor: Theme.of(context).colorScheme.error,
                foregroundColor: Theme.of(context).colorScheme.onError,
              )
              : FloatingActionButton.extended(
                onPressed: () {
                  setState(() => _contractions.add(Contraction(DateTime.now())));
                },
                backgroundColor: Colors.green[600],
                icon: const Icon(Icons.start),
                label: Text(AppLocalizations.of(context)!.actionStart),
              ),
    );
  }

  TimelineTile _buildTimelineTile({
    required BuildContext context,
    required _BulletPoint indicator,
    required Contraction contraction,
    Contraction? previousContraction,
    Contraction? nextContraction,
    bool lineUnder = false,
    bool lineAbove = false,
  }) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.25,
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
                  onTap: () {
                    Duration maxDuration = nextContraction?.start.difference(contraction.start) ?? DateTime.now().difference(contraction.start);
                    showDurationPicker(context: context, initialTime: contraction.duration, baseUnit: BaseUnit.second, upperBound: maxDuration).then((
                      selectedDuration,
                    ) {
                      if (selectedDuration != null) {
                        // prevent editing labour durations into the future or into the next contraction since that would skew the frequence.

                        if (selectedDuration.inSeconds < maxDuration.inSeconds) {
                          setState(() => contraction.end = contraction.start.add(selectedDuration));
                        } else {
                          // setState(() => contraction.end = contraction.start.add(maxDuration));
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    nextContraction == null
                                        ? AppLocalizations.of(context)!.errorContractionInFuture
                                        : AppLocalizations.of(context)!.errorContractionOverlap
                                ),
                              )
                          );
                        }
                        ;
                      }
                    });
                  },
                  child: Row(children: [Text(Contraction.getDurationFormatted(contraction.duration, AppLocalizations.of(context)!)), Icon(Icons.arrow_drop_down)]),
                ),
            previousContraction != null
                ? Text(Contraction.getDurationFormatted(contraction.start.difference(previousContraction.start), AppLocalizations.of(context)!))
                : Text("---"),
            contraction.isOngoing()
                ? SizedBox(width: 30)
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
