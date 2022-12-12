import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:flutter/material.dart';

class FlutterAnalogClockDemo extends StatelessWidget {
  const FlutterAnalogClockDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.grey,
          child: const FlutterAnalogClock(
            dialColor: Colors.lightGreen,
            borderColor: Colors.black,
            // numberColor: Colors.transparent,
            borderWidth: 1.0,
          ),
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
    dialColor: Colors.green,
    hourHandColor: Colors.red,
    minuteHandColor: Colors.purple,
    secondHandColor: Colors.blue.shade200,
    borderColor: Colors.green.shade700,
    markingColor: Colors.white,
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
    dialColor: Colors.yellow,
    hourHandColor: Colors.red,
    minuteHandColor: Colors.green,
    markingColor: Colors.green,
    numberColor: Colors.blue,
    centerPointColor: Colors.white,
    borderWidth: 0,
    showSecondHand: false,
    showTicks: false,
  );
}

Widget buildClock5() {
  return const FlutterAnalogClock(
    dialColor: Colors.blue,
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
    dialColor: Colors.red,
    hourHandColor: Colors.white,
    minuteHandColor: Colors.white,
    secondHandColor: Colors.white,
    centerPointColor: Colors.white,
    borderColor: Colors.red.shade700,
    borderWidth: 24,
    markingColor: Colors.blue.shade900,
  );
}