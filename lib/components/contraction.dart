class Contraction {
  final DateTime start;
  late DateTime? end;
  final Stopwatch _stopwatch;

  Contraction(this.start) : _stopwatch = Stopwatch()..start();

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
    return _stopwatch.elapsed;
  }

  String getDurationFormatted() {
    return [duration.inMinutes, duration.inSeconds].map((seg) => seg.remainder(60).toString().padLeft(2, '0')).join(':');
  }

  @override
  String toString() {
    return getDurationFormatted();
  }
}