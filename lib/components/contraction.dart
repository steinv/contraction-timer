import 'dart:convert';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:contractions/generated/l10n.dart';

class Contraction {
  late DateTime start;
  late DateTime? end = null;
  late Stopwatch _stopwatch;

  Contraction(this.start) : _stopwatch = Stopwatch()..start();
  Contraction.deserialize(String b64) {
    String jsonString = utf8.decode(base64Decode(b64));
    Map<String, dynamic> json = jsonDecode(jsonString);

    start =  DateTime.parse(json['start']);
    end =  DateTime.parse(json['end']);
    _stopwatch = Stopwatch();
  }

  bool isOngoing() {
    return _stopwatch.isRunning;
  }

  void endContraction() {
    _stopwatch.stop();
    end = DateTime.now();
  }

  Duration getTimeSince(Contraction newContraction) {
    return end != null ? end!.difference(newContraction.start) : const Duration();
  }

  Duration get duration {
    return end?.difference(start) ?? _stopwatch.elapsed;
  }

  String serialize() {
    Map<String, dynamic> json = {
      'start': start.toIso8601String(),
      'end': end?.toIso8601String(),
    };

    // Convert Map to JSON string and then to Base64
    String jsonString = jsonEncode(json);
    return base64Encode(utf8.encode(jsonString));
  }

  @override
  String toString() {
    return duration.toString();
  }

  static String getDurationFormatted(Duration duration, AppLocalizations appLocalizations) {
    if(duration.inDays > 0) {
      return appLocalizations.days(duration.inDays);
    } else if(duration.inHours > 0) {
      String hours = duration.inHours.remainder(24).toString();
      String minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
      return appLocalizations.durationHours(hours, minutes);
    } else {
      String minutes = duration.inMinutes.remainder(60).toString();
      String seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
      return appLocalizations.durationMin(minutes, seconds);
    }
  }
}
