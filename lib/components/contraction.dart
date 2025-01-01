import 'dart:convert';

class Contraction {
  late DateTime start;
  late DateTime? end = null;
  late Stopwatch _stopwatch;

  Contraction(this.start) : _stopwatch = Stopwatch()..start();
  Contraction.deserialize(String b64) {
    String jsonString = utf8.decode(base64Decode(b64));
    Map<String, dynamic> json = jsonDecode(jsonString);

    this.start =  DateTime.parse(json['start']);
    this.end =  DateTime.parse(json['end']);
    this._stopwatch = Stopwatch();
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

  static String getDurationFormatted(Duration duration) {
    return [duration.inMinutes, duration.inSeconds].map((seg) => seg.remainder(60).toString().padLeft(2, '0')).join(':');
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
    return getDurationFormatted(duration);
  }
}