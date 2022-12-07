import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:flutter/material.dart';

class FlutterAnalogClockDemo extends StatelessWidget {
  const FlutterAnalogClockDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(child: buildClock1(),),
                  Expanded(child: buildClock2(),),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(child: buildClock3(),),
                  Expanded(child: buildClock4(),),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(child: buildClock5(),),
                  Expanded(child: buildClock6(),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildClock1() {
  return const FlutterAnalogClock();
}

Widget buildClock2() {
  DateTime dateTime = DateTime.now();
  dateTime = dateTime.add(const Duration(hours: 8));
  return FlutterAnalogClock.dark(
    dateTime: dateTime,
    child: const Center(
      child: Padding(
        padding: EdgeInsets.only(top: 100),
        child: Text(
          'GMT + 8',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}

Widget buildClock3() {
  DateTime dateTime = DateTime.now();
  dateTime = dateTime.add(const Duration(hours: -8));
  return FlutterAnalogClock(
    dateTime: dateTime,
    dialPlateColor: Colors.green,
    hourHandColor: Colors.red,
    minuteHandColor: Colors.purple,
    secondHandColor: Colors.blue.shade200,
    borderColor: Colors.green.shade700,
    tickColor: Colors.white,
    centerPointColor: Colors.yellow,
    showNumber: false,
    child: const Center(
      child: Padding(
        padding: EdgeInsets.only(bottom: 100),
        child: Text(
          'GMT - 8',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}

Widget buildClock4() {
  return const FlutterAnalogClock(
    hourNumbers: ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X', 'XI', 'XII'],
    dialPlateColor: Colors.yellow,
    hourHandColor: Colors.red,
    minuteHandColor: Colors.green,
    tickColor: Colors.green,
    numberColor: Colors.blue,
    centerPointColor: Colors.white,
    borderWidth: 0,
    showSecondHand: false,
    showTicks: false,
  );
}

Widget buildClock5() {
  return const FlutterAnalogClock(
    dialPlateColor: Colors.blue,
    hourHandColor: Colors.white,
    centerPointColor: Colors.white,
    showMinuteHand: false,
    showSecondHand: false,
    showBorder: false,
    showTicks: false,
    showNumber: false,
  );
}

Widget buildClock6() {
  return FlutterAnalogClock(
    hourNumbers: const ['', '', '3', '', '', '6', '', '', '9', '', '', '12'],
    dialPlateColor: Colors.red,
    hourHandColor: Colors.white,
    minuteHandColor: Colors.white,
    secondHandColor: Colors.white,
    centerPointColor: Colors.white,
    borderColor: Colors.red.shade700,
    borderWidth: 24,
    tickColor: Colors.blue.shade900,
  );
}