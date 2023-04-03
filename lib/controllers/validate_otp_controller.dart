import 'dart:async';

import 'package:get/get.dart';
import 'package:socialv/utils/const_utils.dart';

class OtpController extends GetxController {
  bool hasError = false;

  changeerror(val) {
    hasError = val;
    update();
  }

  String currentText = "";
  changeotp(val) {
    currentText = val;
  }

  Timer? textTimer;
  late DateTime startTime;
  String showTime = "00:30";

  int timer = 30;
  int tick = 0;
  final String data = "00:00";
  startTimer() {
    textTimer?.cancel();
    // timer = 30;
    tick = 0;
    textTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      tick = timer.tick;
      if (timer.tick == 30) {
        timer.cancel();
      }
      update();
    });
  }

  String formatDuration(int second) {
    final ms = second * 1000;
    int seconds = ms ~/ 1000;

    final int hours = seconds ~/ 3600;
    seconds = seconds % 3600;

    final minutes = seconds ~/ 60;
    seconds = seconds % 60;

    final hoursString = hours >= 10
        ? '$hours'
        : hours == 0
            ? '00'
            : '0$hours';

    final minutesString = minutes >= 10
        ? '$minutes'
        : minutes == 0
            ? '00'
            : '0$minutes';

    final secondsString = seconds >= 10
        ? '$seconds'
        : seconds == 0
            ? '00'
            : '0$seconds';

    final formattedTime =
        '${hoursString == '00' ? '' : '$hoursString:'}$hoursString:$minutesString:$secondsString';

    return formattedTime;
  }
}
