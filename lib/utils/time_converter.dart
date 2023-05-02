class TimeConverter {
  static String formatMilliseconds(int value) {
    String twoDigits(int v) => v.toString().padLeft(2, '0');
    final Duration duration = Duration(milliseconds: value);
    final int minutes = duration.inMinutes;
    final String seconds = twoDigits(duration.inSeconds.remainder(60));

    return '$minutes:$seconds';
  }
}
