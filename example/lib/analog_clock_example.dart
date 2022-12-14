import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_analog_clock/flutter_analog_clock.dart';
class AnalogClockDemo extends StatefulWidget {
  const AnalogClockDemo({super.key});

  @override
  State<AnalogClockDemo> createState() => _AnalogClockDemoState();
}

class _AnalogClockDemoState extends State<AnalogClockDemo> {
  bool _clockIsLive = false;
  DateTime _dateTime = DateTime.now();
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
      body: Container(
        color: Colors.grey,
        child: SafeArea(
          child: AnalogClock(
            key: clockKey,
            dateTime: _dateTime,
            // dateTime: DateTime(2022, DateTime.december, 13, 15, 17, 18),
            // isLive: false,
            // markingColor: _markingColor,
            // hourHandColor: _hourHandColor,
            dialBorderWidthFactor: _dialBorderWidthFactor,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  // clockKey.currentState?.isLive = !clockKey.currentState!.isLive;
                  clockKey.currentState?.dateTime = DateTime(2022, DateTime.december, 13, 15, 17, 18);
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
            // hourHandColor: Colors.red,
            // minuteHandColor: Colors.green,
            // secondHandColor: Colors.blue,
            // centerPointColor: Colors.amberAccent,
          ),
/*
          child: SingleChildScrollView(
            child: Column(
              children: [
                FlutterAnalogClock(
                  dateTime: DateTime(2022, DateTime.december, 13, 15, 17, 19),
                  isLive: false,
                  dialColor: _dialColor,
                  dialBorderColor: _dialBorderColor,
                  dialBorderWidthFactor: _dialBorderWidthFactor,
                  markingColor: _markingColor,
                  markingRadiusFactor: _markingRadiusFactor,
                  markingWidthFactor: _markingWidthFactor,
                  hourNumbers: const ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'],
                  hourNumberColor: _hourNumberColor,
                  hourNumberSizeFactor: _hourNumberSizeFactor,
                  hourNumberRadiusFactor: 1,
                  hourHandColor: _hourHandColor,
                  minuteHandColor: _minuteHandColor,
                  secondHandColor: _secondHandColor,
                  hourHandWidthFactor: _hourHandWidthFactor,
                  hourHandLengthFactor: _hourHandLengthFactor,
                  minuteHandWidthFactor: _minuteHandWidthFactor,
                  minuteHandLengthFactor: _minuteHandLengthFactor,
                  secondHandWidthFactor: _secondHandWidthFactor,
                  secondHandLengthFactor: _secondHandLengthFactor,
                ),
                Wrap(
                  children: [
                    ElevatedButton(
                      onPressed: () => setState(() => _dialColor = getRandomColor()),
                      child: const Text('Dial color'),
                    ),
                    ElevatedButton(
                      onPressed: () => setState(() => _dialBorderColor = getRandomColor()),
                      child: const Text('Border color'),
                    ),
                    ElevatedButton(
                      onPressed: () => setState(() => _dialBorderWidthFactor = _random.nextDouble()),
                      child: const Text('Border factor'),
                    ),
                    ElevatedButton(
                      onPressed: () => setState(() => _hourNumberColor = getRandomColor()),
                      child: const Text('Hour Number color'),
                    ),
                    ElevatedButton(
                      onPressed: () => setState(() => _hourNumberSizeFactor = _random.nextDouble()),
                      child: const Text('Hour Number factor'),
                    ),
                    ElevatedButton(
                      onPressed: () => setState(() => _markingColor = getRandomColor()),
                      child: const Text('Markings color'),
                    ),
                    ElevatedButton(
                      onPressed: () => setState(() => _markingRadiusFactor = _random.nextDouble()),
                      child: const Text('Marking radius factor'),
                    ),
                    ElevatedButton(
                      onPressed: () => setState(() => _markingWidthFactor = _random.nextDouble()),
                      child: const Text('Marking width factor'),
                    ),
                    ElevatedButton(
                      onPressed: () => setState(() => _hourHandColor = getRandomColor()),
                      child: const Text('Hour hand color'),
                    ),
                    ElevatedButton(
                      onPressed: () => setState(() => _minuteHandColor = getRandomColor()),
                      child: const Text('Minute hand color'),
                    ),
                    ElevatedButton(
                      onPressed: () => setState(() => _secondHandColor = getRandomColor()),
                      child: const Text('Second hand color'),
                    ),
                    ElevatedButton(
                      onPressed: () => setState(() => _hourHandWidthFactor = _random.nextDouble()),
                      child: const Text('Hour hand width factor'),
                    ),
                    ElevatedButton(
                      onPressed: () => setState(() => _hourHandLengthFactor = _random.nextDouble()),
                      child: const Text('Hour hand length factor'),
                    ),
                    ElevatedButton(
                      onPressed: () => setState(() => _minuteHandWidthFactor = _random.nextDouble()),
                      child: const Text('Minute hand width factor'),
                    ),
                    ElevatedButton(
                      onPressed: () => setState(() => _minuteHandLengthFactor = _random.nextDouble()),
                      child: const Text('Minute hand length factor'),
                    ),
                    ElevatedButton(
                      onPressed: () => setState(() => _secondHandWidthFactor = _random.nextDouble()),
                      child: const Text('Second hand width factor'),
                    ),
                    ElevatedButton(
                      onPressed: () => setState(() => _secondHandLengthFactor = _random.nextDouble()),
                      child: const Text('Second hand length factor'),
                    ),
                  ]
                ),
              ],
            ),
          ),
*/
        ),
      ),
    );
  }

  Color getRandomColor() => Color.fromARGB(255, _random.nextInt(256), _random.nextInt(256), _random.nextInt(256));

}
