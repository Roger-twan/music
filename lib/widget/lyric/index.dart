import 'package:flutter/material.dart';
import 'lyric_wrapper.dart';

class LyricScreen extends StatefulWidget {
  const LyricScreen({super.key});

  @override
  State<LyricScreen> createState() => _LyricScreenState();
}

class _LyricScreenState extends State<LyricScreen> {
  @override
  Widget build(BuildContext context) {
    double baseFontSize = MediaQuery.of(context).size.width * 0.05;
    const double minFontSize = 26;
    const double maxFontSize = 40;
    if (baseFontSize > maxFontSize) {
      baseFontSize = maxFontSize;
    } else if (baseFontSize < minFontSize) {
      baseFontSize = minFontSize;
    }

    String lyr =
        '[00:30.16]你有多久没有看到 满天的繁星\n[00:37.34]城市夜晚虚伪的光明 遮住你的眼睛\n[00:44.40]连周末的电影 也变得不再有趣\n[00:51.71]疲惫的日子里 有太多的问题\n[01:00.96]你有多久单身一人 不再去旅行\n[01:08.20]习惯下班回到家里 冷冰冰的空气\n[01:15.58]爱情这东西 你已经不再有勇气\n[01:22.64]情歌有多动听 你就有多怀疑\n[01:30.60]许多人来来去去 相聚又别离\n[01:38.29]也有人喝醉哭泣 在一个人的北京\n[01:45.16]也许我成功失意 慢慢的老去\n[01:52.76]能不能让我留下片刻的回忆\n[01:58.95]\n[04:34.24]也有人匆匆逃离 这一个人的北京\n[04:41.37]也许有一天我们 一起离开这里\n[04:48.87]离开了这里 在晴朗的天气\n[04:55.08]';

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      color: Colors.black,
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: [
          Text('Hotel California',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: baseFontSize,
                color: Colors.white,
              )),
          Text('Eagle',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: baseFontSize * 0.6,
              )),
          Expanded(
              child: Container(
            padding: const EdgeInsets.only(top: 50),
            width: double.infinity,
            child: CustomPaint(
              painter: LyricWrapper(lyr, baseFontSize),
            ),
            // child: Column(
            //   children: [
            //     const SizedBox(height: 100),
            //     CircularProgressIndicator(color: Colors.grey[800]),
            //   ],
            // ),
          ))
        ],
      ),
    );
  }
}
