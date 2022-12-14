import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_analog_clock/flutter_analog_clock.dart';
class AnalogClockDemo extends StatefulWidget {
  const AnalogClockDemo({super.key});

  @override
  State<AnalogClockDemo> createState() => _AnalogClockDemoState();
}

class _AnalogClockDemoState extends State<AnalogClockDemo> {
  bool _isKeepTime = true;
  DateTime? _dateTime;
  Color? _dialColor;
  Color? _dialBorderColor;
  double? _dialBorderWidthFactor = 0.01;
  Color? _markingColor;
  double? _markingRadiusFactor;
  double? _markingWidthFactor;
  Color? _hourNumberColor;
  double? _hourNumberSizeFactor;
  Color? _hourHandColor;
  Color? _minuteHandColor;
  Color? _secondHandColor;
  double? _hourHandWidthFactor;
  double? _hourHandLengthFactor;
  double? _minuteHandWidthFactor;
  double? _minuteHandLengthFactor;
  double? _secondHandWidthFactor;
  double? _secondHandLengthFactor;

  final math.Random _random = math.Random();
  final GlobalKey<AnalogClockState> clockKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.grey,
          child: AnalogClock(
            key: clockKey,
            dateTime: _dateTime,
            // hourNumbers: const ['a','b','c'],
            // dateTime: DateTime(2022, DateTime.december, 13, 15, 17, 18),
            isKeepTime: _isKeepTime,
            dialBorderWidthFactor: 0.1, //_dialBorderWidthFactor,
/*
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  clockKey.currentState?.isKeepTime = !clockKey.currentState!.isKeepTime;
                  // clockKey.currentState?.dateTime = DateTime(2022, DateTime.december, 13, 15, 17, 18);
                  // setState(() {
                  //   _dialBorderWidthFactor = _random.nextDouble() / 4;
                  //   // _hourHandColor = getRandomColor();
                  //   _dateTime = _dateTime.add(const Duration(hours: 1));
                  //   // _hourHandColor = Colors.red;
                  //   // _clockIsLive = !_clockIsLive;
                  // });
                },
                child: Text('isLive'),
              ),
            ),
*/
            // hourHandColor: Colors.red,
            // minuteHandColor: Colors.green,
            // secondHandColor: Colors.blue,
            // centerPointColor: Colors.amberAccent,
          ),
        ),
      ),
    );
  }

  Color getRandomColor() => Color.fromARGB(255, _random.nextInt(256), _random.nextInt(256), _random.nextInt(256));

}
