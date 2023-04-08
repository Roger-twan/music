class Lyric {
  String lyric;
  Duration? startTime;
  Duration? endTime;

  Lyric(this.lyric, {this.startTime, this.endTime});
}

List<Lyric> formatLyric(String lyricStr) {
  RegExp reg = RegExp(r'^\[\d{2}');
  List<String> realLyricStr =
      lyricStr.split('\n').where((element) => reg.hasMatch(element)).toList();

  List<Lyric> result = realLyricStr.map((str) {
    String time = str.substring(0, str.indexOf(']'));
    String lyric = str.substring(str.indexOf(']') + 1);

    time = str.substring(1, time.length - 1);

    int minuteSeparatorIndex = time.indexOf(':');
    int secondSeparatorIndex = time.indexOf('.');

    return Lyric(
      lyric,
      startTime: Duration(
        minutes: int.parse(time.substring(0, minuteSeparatorIndex)),
        seconds: int.parse(
            time.substring(minuteSeparatorIndex + 1, secondSeparatorIndex)),
        milliseconds: int.parse(time.substring(secondSeparatorIndex + 1)),
      ),
    );
  }).toList();

  for (int i = 0; i < result.length - 1; i++) {
    result[i].endTime = result[i + 1].startTime;
  }

  return result;
}
