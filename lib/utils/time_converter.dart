class TimeConverter {
  static String ms2ms(int value) {
    final Duration duration = Duration(milliseconds: value);
    final int minutes = duration.inMinutes;
    final int seconds = duration.inSeconds.remainder(60);

    return '$minutes:$seconds';
  }
}
